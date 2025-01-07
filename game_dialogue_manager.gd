extends Node

signal give_crop_seeds

signal close_chest

signal feed_the_animals

func action_feed_the_animals() -> void:
	feed_the_animals.emit()

func do_close_chest() -> void:
	close_chest.emit()

func action_give_crop_seeds() -> void:
	give_crop_seeds.emit()


func stop_world()-> void:
	# 暂停当前页面活动
	get_tree().paused = true
	
func run_world() -> void:
	get_tree().paused = false
