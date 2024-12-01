class_name NodeState
extends Node

signal transition

# 当前是否正在激活工具(正在使用)
var activated:bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_process(delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	pass

func _on_next_transitions()->void:
	pass

func _on_enter()->void:
	pass
	
	
func _on_exit()->void:
	pass
