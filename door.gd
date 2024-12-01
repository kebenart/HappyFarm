class_name Door
extends StaticBody2D

@onready var door_animation_player: AnimatedSprite2D = $DoorAnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interoperable: Interoperable = $Interoperable


func _ready() -> void:
	door_animation_player.play("default")
	interoperable.interaction_activited.connect(_open)
	interoperable.interaction_leave.connect(_close)
	set_collision_layer_value(3,true)

func _open(body:Node2D):
	door_animation_player.play("open")
	#collision_shape_2d.disabled = true
	#set_collision_mask_value(2,false)
	set_collision_layer_value(3,false)
	
func _close(body:Node2D):
	door_animation_player.play("close")
	#collision_shape_2d.disabled = false
	#set_collision_mask_value(2,true)
	set_collision_layer_value(3,true)
