extends Node


# 库存变更
signal inventory_changed(name: String)

# 库存
var inventory:Dictionary = {
	"log":0,
	"stone":0,
	"egg":0,
	"milk":0,
	"wheat":0,
	"eggplant":0
}


func add_inventory(name:String) -> void:
	if inventory.has(name):
		inventory[name] = inventory[name]+1
		inventory_changed.emit(name)
