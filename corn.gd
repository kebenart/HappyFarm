extends Node2D

var corn_harvest_scene = preload("res://collectable_wheat.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_particles: GPUParticles2D = $WateringParticles
@onready var flower_particles: GPUParticles2D = $FlowerParticles
@onready var growth_cycle_component: GrowthCycleComponent = $GrowthCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent


var growth_state:DataTypes.GrowthStates = DataTypes.GrowthStates.Seed

func _ready() -> void:
	watering_particles.emitting = false
	flower_particles.emitting = false
	hurt_component.hurt.connect(on_hurt)
	growth_cycle_component.crop_maturity.connect(on_maturity)
	growth_cycle_component.crop_harvesting.connect(on_harvesting)
	

func _process(delta: float) -> void:
	growth_state = growth_cycle_component.get_current_growth_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Maturity:
		flower_particles.emitting = true
	
	
func on_hurt(hit_damage: int)->void:
	# 如果第一次被交水,则显示粒子效果
	if !growth_cycle_component.is_watered:
		print("被交水了")
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		growth_cycle_component.is_watered = true


func on_maturity() -> void:
	flower_particles.emitting = true

func on_harvesting() -> void:
	var corn_harvest = corn_harvest_scene.instantiate() as Node2D
	corn_harvest.global_position = global_position
	get_parent().add_child(corn_harvest)
	queue_free()
