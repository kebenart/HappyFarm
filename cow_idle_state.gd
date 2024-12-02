extends NodeState

@export var chicken:CharacterBody2D
@export var animatedPlayer:AnimatedSprite2D

@export var max_idle_wait_time:int = 15
@export var min_idle_wait_time:int = 8
var idle_wait_time = 5

var idle_timer = Timer.new()

var idle_timeout:bool = false


func _ready() -> void:
	idle_wait_time = randi_range(min_idle_wait_time,max_idle_wait_time)
	idle_timer.wait_time = idle_wait_time
	idle_timer.timeout.connect(_idle_wait_timeout)
	add_child(idle_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_process(delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	pass
	

func _on_next_transitions()->void:
	if idle_timeout:
		transition.emit("walk")
		return
	
	pass


func _on_enter()->void:
	animatedPlayer.play("idle")
	idle_timer.start()
	
	
func _on_exit()->void:
	animatedPlayer.stop()
	idle_timer.stop()
	idle_timeout = false

	
func _idle_wait_timeout()->void:
	idle_timeout = true
