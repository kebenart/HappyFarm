class_name Water
extends NodeState

@export var player:Player
@export var animatedPlayer:AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_process(delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	pass
	

func _on_next_transitions()->void:
	if !animatedPlayer.is_playing():
		transition.emit("idle")


func _on_enter()->void:
	if player.direction == Vector2.UP:
		animatedPlayer.play("water_up")
	elif player.direction == Vector2.RIGHT:
		animatedPlayer.play("water_right")
	elif player.direction == Vector2.DOWN:
		animatedPlayer.play("water_down")
	elif player.direction == Vector2.LEFT:
		animatedPlayer.play("water_left")
	else:
		animatedPlayer.play("water_down")
	activated = true
	
func _on_exit()->void:
	animatedPlayer.stop()
	activated = false
	player.hit_component_collision_share.disabled = true



func _on_animated_sprite_2d_frame_changed(frame:int) -> void:
	if not frame == 1:
		return
	if player.direction == Vector2.UP:
		player.hit_component_collision_share.position = Vector2(6,-7)
	elif player.direction == Vector2.RIGHT:
		player.hit_component_collision_share.position = Vector2(20,2)
	elif player.direction == Vector2.DOWN:
		player.hit_component_collision_share.position = Vector2(-6,15)
	elif player.direction == Vector2.LEFT:
		player.hit_component_collision_share.position = Vector2(-20,2)
	else:
		player.hit_component_collision_share.position = Vector2(-6,5)
		
	player.hit_component_collision_share.disabled = false
