extends Node

var selected_tool:DataTypes.Tools = DataTypes.Tools.NONE


signal tool_selected(tool:DataTypes.Tools)


func select_tool(tool:DataTypes.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool
