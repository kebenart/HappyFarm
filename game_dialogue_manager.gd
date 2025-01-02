extends Node

signal give_crop_seeds


func action_give_crop_seeds() -> void:
	give_crop_seeds.emit()


func stop_world()-> void:
	# 暂停当前页面活动
	get_tree().paused = true
	
func run_world() -> void:
	get_tree().paused = false
