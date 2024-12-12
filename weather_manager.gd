class_name weather_manager
extends Node

var is_raining: bool = false

signal open_rain
signal close_rain
signal raining


# 后续拆分,制作整体的天气系统, 例如天气管理器, 定义枚举, 
func _ready() -> void:
	DayAndNightManager.time_tick_day.connect(on_time_tick_day)
	DayAndNightManager.time_tick.connect(on_time_tick)


func on_time_tick_day(day:int) -> void:
	var next_rain = randi_range(0,7) == 0
	
	if next_rain == is_raining:
		return

	is_raining = next_rain
	if !is_raining:
		close_rain.emit()
		return
	
	if is_raining:
		open_rain.emit()
		return

 
func on_time_tick(day:int, hour: int, minute: int) -> void:
	if is_raining:
		raining.emit()
