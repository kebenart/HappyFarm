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
	inventory.get_or_add(name)
	
	if inventory[name] == null:
		inventory[name] = 1
	else:
		inventory[name] += 1
	
	inventory_changed.emit(name)
	
func remove_inventory(name: String) -> void:
	if inventory[name] == null:
		inventory[name] = 0
	else:
		if inventory[name] > 0: 
			inventory[name] -= 1
	
	inventory_changed.emit(name)
