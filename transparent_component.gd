extends Area2D

@export var transparent:float = 0.5

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var parent = get_parent() as Sprite2D
		parent.modulate.a = transparent


func _on_body_exited(body: Node2D) -> void:
	var parent = get_parent() as Sprite2D
	parent.modulate.a = 1.0
