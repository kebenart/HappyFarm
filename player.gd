class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent

var direction:Vector2

@export var current_tool:DataTypes.Tools
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_matchine: StateMatchine = $StateMatchine


func _ready() -> void:
	ToolManager.tool_selected.connect(_on_tool_selected)

# 动画帧率变化
func _on_animated_sprite_2d_frame_changed() -> void:
	if state_matchine.current_node_state is Chopping:
		var chopping = state_matchine.current_node_state as Chopping
		chopping._on_animated_sprite_2d_frame_changed(animated_sprite_2d.frame)


func _on_tool_selected(tool:DataTypes.Tools)->void:
	current_tool = tool
	hit_component.current_tool = tool
