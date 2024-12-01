class_name CollectableComponent
extends Area2D

@export var collectable_name: String




func _on_body_entered(body: Node2D) -> void:
	print("被收集起来了..")
	if body is Player:
		get_parent().queue_free()
