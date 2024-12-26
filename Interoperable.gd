class_name Interoperable

extends Area2D

signal interaction_activited(body: Node2D)

signal interaction_leave(body: Node2D)
	



func _on_body_exited(body: Node2D) -> void:
	print("out: ",body.name)
	if !body is Player:
		return
	interaction_leave.emit(body)
	


func _on_body_entered(body: Node2D) -> void:
	print("in: ",body.name)
	if !body is Player:
		return
	interaction_activited.emit(body)
