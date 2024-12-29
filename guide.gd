extends CharacterBody2D

@onready var interoperable: Interoperable = $Interoperable
@onready var button: Button = $Button

var in_range: bool

var balloon_Scene = preload("res://dialogue/game_dialogue_ballon.tscn")

func _ready() -> void:
	interoperable.interaction_activited.connect(on_interaction_activited)
	interoperable.interaction_leave.connect(on_interaction_leave)
	button.hide()
	
	
func on_interaction_activited(body: Node2D) -> void:
	button.show()
	in_range = true

	

func on_interaction_leave(body: Node2D) -> void:
	button.hide()
	in_range = false
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("guide") && in_range:
		# 创建对话框
		var balloon: BaseGameDialogueBalloon = balloon_Scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		# 运行对话内容
		balloon.start(load("res://guide.dialogue"),"start")
		
		# 暂停当前页面活动
		get_tree().paused = true		
