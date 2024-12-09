extends Node

# 时间比例
const MINUTES_PRE_DAY:int = 24 * 60
const MINUTES_PRE_HOUR:int = 60

# 用圆常量除以 一天1440分钟, 计算出每分钟需要转动的角度(弧度)
# 类似模拟钟表
const GAME_MINUTE_DURATION:float = TAU / MINUTES_PRE_DAY

var game_speed:float = 5.0

# 初始化时间
var init_day: int = 1
var init_hour: int = 12
var init_minute: int = 30

# 初始化累计时间
var time: float = 0.0
var current_minute: int = -1
var current_day: int = 0

signal game_time(time: float)

# 时间变更
signal time_tick(day:int, hour: int, minute: int)

# 天数变更
signal time_tick_day(day: int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)
	
	recalculate_time()

func set_initial_time() -> void:
	var init_total_minutes = init_day * MINUTES_PRE_DAY + (init_hour * MINUTES_PRE_HOUR) + init_minute
	time = init_total_minutes * GAME_MINUTE_DURATION


func recalculate_time() -> void:
	var total_minutes = int(time / GAME_MINUTE_DURATION)
	var day: int = int (total_minutes / MINUTES_PRE_DAY)
	var current_day_minutes: int = total_minutes % MINUTES_PRE_DAY
	var hour: int = int(current_day_minutes / MINUTES_PRE_HOUR)
	var minute: int = int(current_day_minutes % MINUTES_PRE_HOUR)
	
	if current_minute != minute:
		current_minute = minute
		time_tick.emit(day,hour,minute)
	
	if current_day != day:
		current_day = day
		time_tick_day.emit(day)
