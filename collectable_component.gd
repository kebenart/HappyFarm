class_name CollectableComponent
extends Area2D

@export var collectable_name: String

@export var pickup_effect_scene:PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_inventory(collectable_name)


		call_deferred("add_effect",body)
	
		get_parent().queue_free()


# 添加物品拾取效果
func add_effect(body: Node2D) ->void:
	if !pickup_effect_scene:
		return
	var pickup_effect = pickup_effect_scene.instantiate() as Sprite2D
	pickup_effect.global_position = Vector2(body.global_position.x-5,body.global_position.y)
	body.get_parent().add_child(pickup_effect)
	var tween = body.get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(pickup_effect,"position",Vector2(pickup_effect.position.x,pickup_effect.position.y-20),0.7)
	tween.set_parallel()
	tween.tween_property(pickup_effect,"modulate:a",0,0.7)
	await tween.finished 
	pickup_effect.queue_free()
	
