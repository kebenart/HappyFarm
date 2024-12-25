class_name SaveDataComponent
extends Node

# 获取父节点
@onready var parent_node:Node2D = get_parent() as Node2D

# 需要保存的数据资源
@export var save_data_resource: NodeDataResource

func _ready() -> void:
	add_to_group("save_data_component")

func _save_data() -> Resource:
	if parent_node == null:
		return null
	
	print("save_player: ",parent_node.name)
	if save_data_resource == null:
		push_error("save_data_resources: ", save_data_resource,parent_node.name)
		
	save_data_resource._save_data(parent_node)
	return save_data_resource
