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
	print("mouse_position: ",mouse_position," cell_position: ",cell_position, " cell_id: ",cell_source_id)
	print("distance: ",distance)

# 添加耕种土地
func add_tilled_soil_cell() -> void:
	if distance < 30.0 && cell_source_id != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position],terrain_set,terrain,true)


# 移除耕种土地
func remove_tilled_soil_cell() -> void:
	if distance < 30.0:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position],0,-1,true)
