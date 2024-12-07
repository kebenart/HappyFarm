extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload( "res://collectable_log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(_do_hurt)
	damage_component.dead.connect(_on_dead)
	

func _do_hurt(damage:int)->void:
	damage_component._hurt_damage(damage)
	var tempMaterial = material as ShaderMaterial
	tempMaterial.set_shader_parameter("shake_intensity",1.0)
	await get_tree().create_timer(1.0).timeout
	tempMaterial.set_shader_parameter("shake_intensity",0.0)
	
func _on_dead()->void:
	call_deferred("add_log_scene")
	queue_free()
	
func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = Vector2(global_position.x,global_position.y+9)
	get_parent().add_child(log_instance)
