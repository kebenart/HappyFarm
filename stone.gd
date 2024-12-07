extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload( "res://collectable_stone.tscn")

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
	call_deferred("add_collectable_stone_scene")
	queue_free()
	
func add_collectable_stone_scene() -> void:
	print("添加可收集石头")
	var stone_instance = stone_scene.instantiate() as Node2D
	stone_instance.global_position = Vector2(global_position.x,global_position.y+4)
	
	get_parent().add_child(stone_instance)
