
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
		animatedPlayer.play("chopping_up")
	elif player.direction == Vector2.RIGHT:
		animatedPlayer.play("chopping_right")
	elif player.direction == Vector2.DOWN:
		animatedPlayer.play("chopping_down")
	elif player.direction == Vector2.LEFT:
		animatedPlayer.play("chopping_left")
	else:
		animatedPlayer.play("chopping_down")
	
func _on_exit()->void:
	animatedPlayer.stop()
