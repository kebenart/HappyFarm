class_name SaveLevelDataComponent
extends Node

# 保存场景数据资源

# 场景名
var level_scene_name: String
# 保存目录
var save_game_data_path: String = "user://game_data/"
# 保存的文件名
var save_file_name: String = "save_%s_game_data.tres"

# 游戏场景资源
var game_data_resource: SaveGameDataResource

func _ready() -> void:
	add_to_group("save_level_data_component")
	level_scene_name = get_parent().name


func save_node_data() ->void:
	# 获取节点树中所有的 保存游戏组件
	var nodes = get_tree().get_nodes_in_group("save_data_component")
	game_data_resource = SaveGameDataResource.new()
	
	# 记录保存节点组件数据,添加到 游戏存档中
	if nodes != null:
		for node in nodes:
			if node is SaveDataComponent:
				var save_data_resource: NodeDataResource = node._save_data()
				if node.parent_node is Player:
					print("save player ---->: ",str(save_data_resource.node_name))
				
				var save_final_resource:NodeDataResource = save_data_resource.duplicate(true)
				#print("save final resource: ",str(save_final_resource.node_name))
				game_data_resource.save_data_nodes.append(save_final_resource)

# 保存游戏
func save_game() -> void:
	# 如果目录不存在,则新建
	if !DirAccess.dir_exists_absolute(save_game_data_path):
		DirAccess.make_dir_absolute(save_game_data_path)
		
	# 存档名
	var level_save_file_name = save_file_name % level_scene_name
	
	# 记录存档数据
	save_node_data()
	
	# 保存存档
	var result: int = ResourceSaver.save(game_data_resource,save_game_data_path + level_save_file_name)
	
	print("save result: ", result)
	
	
func load_game() -> void:
	# 获取存档文件
	var level_save_file_name: String = save_file_name % level_scene_name
	var save_game_path: String = save_game_data_path + level_save_file_name
	if !FileAccess.file_exists(save_game_path):
		return
	
	# 读取文件
	game_data_resource = ResourceLoader.load(save_game_path)
	if game_data_resource == null:
		return
	
	# 加载存档内容
	var root_node: Window = get_tree().root
	for resource in game_data_resource.save_data_nodes:
		if resource is Resource:
			if resource is NodeDataResource:
				var vv = resource as NodeDataResource
				if vv.node_name == "Player":
					print("load player ----> : ",str(vv.global_position))
					vv.parent_node_path
				
				resource._load_data(root_node)
