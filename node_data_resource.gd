class_name NodeDataResource
extends Resource
# 节点数据资源

# 坐标
@export var global_position: Vector2

# 节点的路径
@export var node_path: NodePath

# 父节点的路径
@export var parent_node_path: NodePath

@export var node_name: String

# 保存节点数据
func _save_data(node: Node2D) -> void:
	# 记录当前节点的全局坐标,和位置
	global_position = node.global_position
	node_name = node.name
	print("save_name: ",node_name)
	node_path = node.get_path()
	
	var parent_node = node.get_parent()
	
	if parent_node != null:
		parent_node_path = parent_node.get_path()
		


func _load_data(window: Window) -> void:
	pass
