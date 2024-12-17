class_name CropsCursorComponent
extends Node

@export var tilled_soil_timemap_layer: TileMapLayer

@onready var player:Player = get_tree().get_first_node_in_group("player")

# 判断 鼠标点击位置和,单元格距离, 进行设置

# TODO 遗留问题
# 1.土地耕种范围问题
# 2.移除土地,没有自动移除作物
# 3.作物交水范围问题
# 4.鼠标点击范围区间需要调试
# 5.同一位置可同时种植作物问题.
# 6.没有耕种土地,也可种植问题
# 7.可叠加种植问题


var corn_plant_scene = preload("res://corn.tscn")
var egg_plant_scene = preload("res://eggplant.tscn")

# 鼠标置变量
var mouse_position:Vector2
# 单元格位置变量
var cell_position:Vector2i
# 单元格元id变量
var cell_source_id: int
# 本地单元格位置
var local_cell_position:Vector2
# 距离
var distance: float



# 监听事件
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("clear_ground"):
		if ToolManager.selected_tool == DataTypes.Tools.WHEAT or ToolManager.selected_tool == DataTypes.Tools.EGG_PLANT:
			# 获取鼠标点击的单元格
			get_cell_under_mouse()
			# 移除
			remove_crop()
			
	elif event.is_action_pressed("Hit"):
		if ToolManager.selected_tool == DataTypes.Tools.WHEAT or ToolManager.selected_tool == DataTypes.Tools.EGG_PLANT:
			# 获取鼠标点击的单元格
			get_cell_under_mouse()
			# 检测生成耕种土地
			add_crop()
			
			

# 获取鼠标下单元格
func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_timemap_layer.get_local_mouse_position()
	# 根据鼠标位置获取单元格位置
	cell_position = tilled_soil_timemap_layer.local_to_map(mouse_position)
	# 根本单元格获取对应id
	cell_source_id = tilled_soil_timemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_timemap_layer.map_to_local(cell_position)
	
	# 获取角色到点击单元格的距离
	distance = player.global_position.distance_to(local_cell_position)
	print("mouse_position: ",mouse_position," cell_position: ",cell_position, " cell_id: ",cell_source_id)
	print("distance: ",distance)

func add_crop() -> void:
	if distance < 30.0:
		if ToolManager.selected_tool == DataTypes.Tools.WHEAT:
			var corn_instance = corn_plant_scene.instantiate() as Node2D
			corn_instance.global_position = local_cell_position
			get_parent().find_child("CropFields").add_child(corn_instance)

		if ToolManager.selected_tool == DataTypes.Tools.EGG_PLANT:
			var egg_plant = egg_plant_scene.instantiate() as Node2D
			egg_plant.global_position = local_cell_position
			# 存放作物到指定节点下
			get_parent().find_child("CropFields").add_child(egg_plant)


	
func remove_crop() -> void:
	if distance < 30.0:
		var nodes = get_parent().find_child("CropFields").get_children()
		for node:Node2D in nodes:
			if node.global_position == local_cell_position:
				node.queue_free()
