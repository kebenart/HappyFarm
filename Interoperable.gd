class_name Interoperable

extends Area2D

signal interaction_activited(body: Node2D)

signal interaction_leave(body: Node2D)
	



func _on_body_exited(body: Node2D) -> void:
	if !body is Player:
		return
	print("离开区域")
	interaction_leave.emit(body)
	


func _on_body_entered(body: Node2D) -> void:
	if !body is Player:
		return
	print("进入区域")
	interaction_activited.emit(body)
