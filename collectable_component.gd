class_name CollectableComponent
extends Area2D

@export var collectable_name: String

#todo浮空效果失败
#var parent_init_position:Vector2
#
#func _ready() -> void:
	##parent_init_position = get_parent().position
	###var tween2 = get_tree().create_tween().set_loops()
	###tween2.tween_callback(func()->void:
		###var tween = create_tween();
		###print("----原动画加载中: " + str(get_parent().position))
		###var y = parent_init_position.y - 4.0
		###tween.tween_property(get_parent(),"position:y",y,0.5)
		###await tween.finished
		###print("----新动画加载中: " + str(get_parent().position))
		###tween.tween_property(get_parent(),"position:y",parent_init_position.y,0.5)
		###print("----最动画加载中: " + str(parent_init_position.y))
		###await tween.finished
		####print("----最动画加载中: " + str(get_parent().position))
	###).set_delay(1.5)
	#
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		InventoryManager.add_inventory(collectable_name)
		get_parent().queue_free()
