class_name FieldCursorComponent
extends Node2D


# 草地瓦片地图层
@export var grass_tilemap_layer:TileMapLayer
# 耕地瓦片地图层
@export var tilled_soil_tilemap_layer:TileMapLayer

# 地形集
@export var terrain_set: int = 0

# 地形下标
@export var terrain:int = 1

# 从组中获取
@onready var player: Player = get_tree().get_first_node_in_group("player")

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
		if ToolManager.selected_tool == DataTypes.Tools.HOE:
			# 获取鼠标点击的单元格
			get_cell_under_mouse()
			# 移除
			remove_tilled_soil_cell()
			
	
	elif event.is_action_pressed("Hit"):
		if ToolManager.selected_tool == DataTypes.Tools.HOE:
			# 获取鼠标点击的单元格
			get_cell_under_mouse()
			# 检测生成耕种土地
			add_tilled_soil_cell()
			
			

# 获取鼠标下单元格
func get_cell_under_mouse() -> void:
	mouse_position = grass_tilemap_layer.get_local_mouse_position()
	# 根据鼠标位置获取单元格位置
	cell_position = grass_tilemap_layer.local_to_map(mouse_position)
	# 根本单元格获取对应id
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)
	
	# 获取角色到点击单元格的距离
	distance = player.global_position.distance_to(local_cell_position)
	var direction = player.global_position.direction_to(local_cell_position)
	#print("direction: ",direction)
	#print("ground: mouse_position: ",mouse_position," cell_position: ",cell_position, " cell_id: ",cell_source_id," local: ",local_cell_position)
	#print("ground-distance: ",distance)


# 添加耕种土地
# 判断是否有障碍物,如果有,则不能添加
func add_tilled_soil_cell() -> void:
	if !check_direction():
		return 
		
	if distance < 20.0 && cell_source_id != -1:
		if has_obstacle():
			return 
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position],terrain_set,terrain,true)
		#tilled_soil_tilemap_layer.notify_runtime_tile_data_update()

func check_direction() -> bool:
	var direction = player.global_position.direction_to(local_cell_position)
	print("player.direction: ",player.direction, "  ,direction: ",direction)
	if player.direction == Vector2.LEFT && direction.x < 0:
		return true
	elif player.direction == Vector2.RIGHT && direction.x > 0:
		return true
	elif player.direction ==Vector2.UP && direction.y < 0:
		return true
	elif player.direction ==Vector2.DOWN && direction.y > 0:
		return true

	return false


func has_obstacle() -> bool:
	var nodes  = get_tree().get_nodes_in_group("obstacle")
	for node in nodes:
		if !node is TileMapLayer:
			continue
		var tilemap_layer = node as TileMapLayer
		var source_id = tilemap_layer.get_cell_source_id(cell_position)
		if source_id != -1:
			return true

	return false

# 移除耕种土地
func remove_tilled_soil_cell() -> void:
	if !check_direction():
		return
		
	# 判断当前位置是否有作物, 如果有先移除作物,
	if distance < 20.0:
		if has_crop():
			remove_crop()
			return
		
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position],0,-1,true)
		#tilled_soil_tilemap_layer.notify_runtime_tile_data_update()


func has_crop() -> bool:
	var nodes = get_parent().find_child("CropFields").get_children()
	for node:Node2D in nodes:
		if node.global_position == local_cell_position:
			return true

	return false
	
func remove_crop() -> void:
	if distance < 20.0:
		var nodes = get_parent().find_child("CropFields").get_children()
		for node:Node2D in nodes:
			if node.global_position == local_cell_position:
				node.queue_free()
