extends PanelContainer

@onready var tool_hoe: Button = $MarginContainer/HBoxContainer/ToolHoe
@onready var tool_chopping: Button = $MarginContainer/HBoxContainer/ToolChopping
@onready var tool_water: Button = $MarginContainer/HBoxContainer/ToolWater
@onready var tool_com: Button = $MarginContainer/HBoxContainer/ToolCom
@onready var tool_eggplant: Button = $MarginContainer/HBoxContainer/ToolEggplant

func _ready() -> void:
	tool_chopping.disabled = true
	tool_water.disabled = true
	tool_com.disabled = true
	tool_eggplant.disabled = true


func _on_tool_hoe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.HOE)


func _on_tool_chopping_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.CHOPPING)


func _on_tool_water_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WATER)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataTypes.Tools.NONE)
		tool_hoe.release_focus()
		tool_chopping.release_focus()
		tool_water.release_focus()
		tool_com.release_focus()
		tool_eggplant.release_focus()


func _on_tool_com_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WHEAT)


func _on_tool_eggplant_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.EGG_PLANT)
