class_name HitComponent
extends Area2D

@export var current_tool:DataTypes.Tools = DataTypes.Tools.NONE

var hit_damage: int = 1


signal hit()

func _on_area_entered(area: Area2D) -> void:
	# 攻击到某物
	hit.emit() 
