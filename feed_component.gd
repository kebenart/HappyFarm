class_name FeedComponent

extends Area2D

var feed_list: Array[String] = ["collectable_wheat","collectable_eggplant"]

signal feed_received()


func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.

# 检测食物是否被宝箱吃掉!
func _on_area_entered(area: Area2D) -> void:
	print(area.get_parent().name)
	# 跳过奖励物品
	if !feed_list.has(area.get_parent().name):
		return
	feed_received.emit()
