extends BaseGameDialogueBalloon

@onready var emotes_panel: Panel = $Balloon/Panel/Dialogue/HBoxContainer/EmotesPanel

# 重写对话框开始方法,播放说话表情
func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	super.start(	dialogue_resource,title,extra_game_states)
	emotes_panel.play_emote("8_speak")
	
	

# 重写对话框开始方法,播放说话表情
func next(next_id: String) -> void:
	super.next(next_id)
	emotes_panel.play_emote("8_speak")
