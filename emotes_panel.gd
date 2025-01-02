extends Panel

@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer
 
var idle_emotes: Array = ["1_idle","3_ear","4_blink","5_happy"]


func _ready() -> void:
	animated_sprite_2d.play("1_idle")
	
#TODO 可增加拾取物品更改表情等优化
func play_emote(animation: String) -> void:
	animated_sprite_2d.play(animation)


func _on_emote_idle_timer_timeout() -> void:
	var index = randi_range(0,3)
	play_emote(idle_emotes[index])
