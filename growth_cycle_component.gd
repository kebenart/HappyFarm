class_name GrowthCycleComponent
extends Node


@export var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Germination

# 生长周期天数
@export_range(5,365) var days_until_harvest: int = 7

# 成熟回调 需要开启粒子效果
signal crop_maturity
# 收获回调
signal crop_harvesting


var is_watered: bool
var starting_day:int
var current_day:int

func _ready() -> void:
	DayAndNightManager.time_tick_day.connect(on_time_tick_day)
	


func on_time_tick_day(day: int)->void:
	# 如果从未交水,植物没法生长
	if is_watered:
		if starting_day == 0:
			starting_day = day
	
		growth_states(starting_day,day)
		harvest_state(starting_day,day)
	

# 获取新的生长状态
func growth_states(starting_day:int,current_day: int):
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		return
	
	var num_states = 5
	# 计算已经经过的天数
	var growth_days_passed  = (current_day - starting_day) % num_states
	# 计算下一个状态
	var state_index = growth_days_passed % num_states + 1
	current_growth_state = state_index
	
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		crop_maturity.emit()


func harvest_state(starting_day:int,current_day:int) -> void:
	if current_growth_state == DataTypes.GrowthStates.Harvesting:
		return
		
	var growth_days_passed  = (current_day - starting_day) % days_until_harvest
	if growth_days_passed == days_until_harvest - 1:
		current_growth_state = DataTypes.GrowthStates.Harvesting
		crop_harvesting.emit()

func get_current_growth_state() -> DataTypes.GrowthStates:
	return current_growth_state
