class_name DamageComponent
extends Node2D

signal dead()

@export var max_damage:int = 3
@export var damage_value:int = 0

func _hurt_damage(damage:int) ->void:
	damage_value += clampi(damage,0,max_damage)
	if damage_value == max_damage:
		dead.emit()
