class_name Idle
extends NodeState

@export var player:Player
@export var animatedPlayer:AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_process(delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	if player.direction == Vector2.LEFT:
		animatedPlayer.play("idle_left")
	elif player.direction == Vector2.RIGHT:
		animatedPlayer.play("idle_right")
	elif player.direction ==Vector2.UP:
		animatedPlayer.play("idle_up")
	elif player.direction ==Vector2.DOWN:
		animatedPlayer.play("idle_down")
	else:
		animatedPlayer.play("idle_down")
	

func _on_next_transitions()->void:
	GameInputEvents.movement_input()
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")

	#print(str(player.current_tool))
	if player.current_tool == DataTypes.Tools.HOE && GameInputEvents.use_tool():
		transition.emit("Hoe")
		
	if player.current_tool == DataTypes.Tools.CHOPPING  && GameInputEvents.use_tool():
		transition.emit("chopping")
	
	if player.current_tool == DataTypes.Tools.WATER && GameInputEvents.use_tool():
		transition.emit("water")


func _on_enter()->void:
	pass
	
	
func _on_exit()->void:
	animatedPlayer.stop()
