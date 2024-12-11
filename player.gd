class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent

var direction:Vector2

@export var current_tool:DataTypes.Tools
@export var hit_component_collision_share:CollisionShape2D 

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_matchine: StateMatchine = $StateMatchine


func _ready() -> void:

	ToolManager.tool_selected.connect(_on_tool_selected)
	hit_component_collision_share.disabled = true
	hit_component_collision_share.position = Vector2(0,0)


# 动画帧率变化
func _on_animated_sprite_2d_frame_changed() -> void:
	if not is_node_ready():
		await ready
	if !state_matchine.current_node_state:
		return
	if state_matchine.current_node_state is Chopping:
		var chopping = state_matchine.current_node_state as Chopping
		chopping._on_animated_sprite_2d_frame_changed(animated_sprite_2d.frame)

	if state_matchine.current_node_state is Water:
		var water = state_matchine.current_node_state as Water
		water._on_animated_sprite_2d_frame_changed(animated_sprite_2d.frame)


func _on_tool_selected(tool:DataTypes.Tools)->void:
	current_tool = tool
	hit_component.current_tool = tool
