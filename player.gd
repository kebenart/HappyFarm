class_name Player
extends CharacterBody2D


var direction:Vector2

@export var current_tool:DataTypes.Tools

@onready var state_matchine: StateMatchine = $StateMatchine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# 动画帧率变化
func _on_animated_sprite_2d_frame_changed() -> void:
	if state_matchine.current_node_state is Chopping:
		var chopping = state_matchine.current_node_state as Chopping
		chopping._on_animated_sprite_2d_frame_changed(animated_sprite_2d.frame)
