class_name HurtComponent
extends Area2D


@export var tool:DataTypes.Tools = DataTypes.Tools.NONE

# 被攻击
signal hurt()

func _on_area_entered(area: Area2D) -> void:
	if !area is HitComponent:
		return
	
	var hit_componment = area as HitComponent
	if tool == hit_componment.current_tool:
		hurt.emit(hit_componment.hit_damage)
	
