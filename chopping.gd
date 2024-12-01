class_name Chopping
extends NodeState

@export var player:Player
@export var animatedPlayer:AnimatedSprite2D
@export var hit_component_collision_share:CollisionShape2D 

func _ready() -> void:
	if not is_node_ready():
		await ready
	hit_component_collision_share.disabled = true
	hit_component_collision_share.position = Vector2(0,0)

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
		#hit_component_collision_share.position = Vector2(3,-12)
	elif player.direction == Vector2.RIGHT:
		animatedPlayer.play("chopping_right")
		#hit_component_collision_share.position = Vector2(9,7)
	elif player.direction == Vector2.DOWN:
		animatedPlayer.play("chopping_down")
		#hit_component_collision_share.position = Vector2(-3,10)
	elif player.direction == Vector2.LEFT:
		animatedPlayer.play("chopping_left")
		#hit_component_collision_share.position = Vector2(-9,7)
	else:
		animatedPlayer.play("chopping_down")
		#hit_component_collision_share.position = Vector2(-3,10)
	activated = true
	
func _on_exit() -> void:
	animatedPlayer.stop()
	activated = false
	hit_component_collision_share.disabled = true


func _on_animated_sprite_2d_frame_changed(frame:int) -> void:
	if not frame == 1:
		return
	if player.direction == Vector2.UP:
		hit_component_collision_share.position = Vector2(3,-12)
	elif player.direction == Vector2.RIGHT:
		hit_component_collision_share.position = Vector2(9,7)
	elif player.direction == Vector2.DOWN:
		hit_component_collision_share.position = Vector2(-3,10)
	elif player.direction == Vector2.LEFT:
		hit_component_collision_share.position = Vector2(-9,7)
	else:
		hit_component_collision_share.position = Vector2(-3,10)
		
	hit_component_collision_share.disabled = false
