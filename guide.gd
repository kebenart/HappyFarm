extends CharacterBody2D

@onready var interoperable: Interoperable = $Interoperable
@onready var button: Button = $Button

func _ready() -> void:
	interoperable.interaction_activited.connect(on_interaction_activited)
	interoperable.interaction_leave.connect(on_interaction_leave)
	button.hide()
	
	
func on_interaction_activited(body: Node2D) -> void:
	button.show()

	

func on_interaction_leave(body: Node2D) -> void:
	button.hide()
	
