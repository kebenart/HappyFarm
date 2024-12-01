class_name DamageComponent
extends Node2D

signal dead()

@export var max_damage:int = 3

@export var damage_value:int = 0:
	set(v):
		damage_value = clampi(v,0,max_damage)
		if damage_value == max_damage:
			dead.emit()
