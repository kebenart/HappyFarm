class_name DayNightCycleComponent
extends CanvasModulate

@export var initial_day: int = 1:
	set(init_day):
		initial_day = init_day
		DayAndNightManager.init_day = init_day
		DayAndNightManager.set_initial_time()

@export var initial_hour: int = 12:
	set(init_hour):
		initial_hour = init_hour
		DayAndNightManager.init_hour = init_hour
		DayAndNightManager.set_initial_time()

@export var initial_minute: int = 30:
	set(init_minute):
		initial_minute = init_minute
		DayAndNightManager.init_minute = init_minute
		DayAndNightManager.set_initial_time()


# 渐变
@export var day_night_gradient_texture: GradientTexture2D


func _ready() -> void:
	DayAndNightManager.init_day = initial_day
	DayAndNightManager.init_hour = initial_hour
	DayAndNightManager.init_minute = initial_minute
	DayAndNightManager.set_initial_time()
	
	DayAndNightManager.game_time.connect(on_game_time)
	
  
func on_game_time(time: float) -> void:
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_night_gradient_texture.gradient.sample(sample_value)
