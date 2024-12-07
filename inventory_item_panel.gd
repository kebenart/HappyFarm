extends PanelContainer

@onready var log_label: Label = $MarginContainer/HBoxContainer/logs/LogLabel
@onready var stone_label: Label = $MarginContainer/HBoxContainer/stones/StoneLabel
@onready var egg_label: Label = $MarginContainer/HBoxContainer/eggs/EggLabel
@onready var milk_label: Label = $MarginContainer/HBoxContainer/milk/MilkLabel
@onready var wheat_label: Label = $MarginContainer/HBoxContainer/wheats/WheatLabel
@onready var eggplant_label: Label = $MarginContainer/HBoxContainer/eggplants/EggplantLabel


func _ready() -> void:
	InventoryManager.inventory_changed.connect(inventory_changed)
	
	
func inventory_changed(name:String)->void:
	if name == "log":
		log_label.text = str(InventoryManager.inventory[name])
	if name == "stone":
		stone_label.text = str(InventoryManager.inventory[name])
	if name == "egg":
		egg_label.text = str(InventoryManager.inventory[name])
	if name == "milk":
		milk_label.text = str(InventoryManager.inventory[name])
	if name == "wheat":
		wheat_label.text = str(InventoryManager.inventory[name])
	if name == "eggplant":
		eggplant_label.text = str(InventoryManager.inventory[name])
