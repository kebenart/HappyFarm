class_name Walk
extends NodeState

@export var player:Player
@export var animatedPlayer:AnimatedSprite2D

var SPEED = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_process(delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	var direction:Vector2 = GameInputEvents.movement_input()
	if direction == Vector2.UP:
		animatedPlayer.play("walk_up")
	elif direction == Vector2.RIGHT:
		animatedPlayer.play("walk_right")
	elif direction == Vector2.DOWN:
		animatedPlayer.play("walk_down")
	elif direction == Vector2.LEFT:
		animatedPlayer.play("walk_left")
	#
	if direction != Vector2.ZERO:
		player.direction = direction
	
	player.velocity = direction * SPEED
	player.move_and_slide()
	

func _on_next_transitions()->void:
	if !GameInputEvents.is_movement_input():
		transition.emit("idle")
	
	if player.current_tool==DataTypes.Tools.HOE \
	and Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		transition.emit("Hoe")
	
	if player.current_tool==DataTypes.Tools.CHOPPING \
	and Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		transition.emit("chopping")
	
	if player.current_tool==DataTypes.Tools.WATER \
	and Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		transition.emit("water")

func _on_enter()->void:
	pass
	
	
func _on_exit()->void:
	animatedPlayer.stop()
