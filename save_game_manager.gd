extends Node


# 监听事件
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		save_game()

# 获取当前场景中的保存关卡组件,进行调用保存
func save_game() -> void:
	var save_level_data_component: SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")
	if  save_level_data_component != null:
		save_level_data_component.save_game()
		
# 获取当前场景中的保存关卡组件,进行调用读取
func load_game() -> void:
	var save_level_data_component: SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")
	
	if save_level_data_component != null:
		save_level_data_component.load_game()
