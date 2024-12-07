class_name CollectableComponent
extends Area2D

@export var collectable_name: String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_inventory(collectable_name)
		get_parent().queue_free()
