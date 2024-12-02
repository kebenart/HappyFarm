extends NodeState

@export var cow:CharacterBody2D
@export var animatedPlayer:AnimatedSprite2D
@export var navigation_agent_2d:NavigationAgent2D

@export var min_speed = 5.0
@export var max_speed = 10.0

var speed:float



func _ready() -> void:
	# 计算避障速度时发出的通知事件
	navigation_agent_2d.velocity_computed.connect(on_safe_velocity_computed)
	
	# 当切换当前第一帧的时候,调用初始化寻路函数
	call_deferred("character_setup")
	
	
func character_setup() -> void:
	await get_tree().physics_frame
	set_movement_target()


func set_movement_target() ->void:
	# 生成导航区域中的随机一个位置
	var target_position:Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(),navigation_agent_2d.navigation_layers,false)
	
	# 设置代理的目标位置
	navigation_agent_2d.target_position = target_position
	
	speed = randf_range(min_speed,max_speed)

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_process(delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	if do_decision():
		return
	#获取下一个移动的位置
	var temp_target_position = navigation_agent_2d.get_next_path_position()
	
	# 获取目标朝向
	var target_direction = cow.global_position.direction_to(temp_target_position)
	
	var temp_velocity = target_direction * speed
	
	# 若开启了避障,把速度提供给导航代理,触发计算安全速度
	if navigation_agent_2d.avoidance_enabled:
		# 判断是否需要翻转鸡的方向
		# 用于处理 鸡的方向
		animatedPlayer.flip_h = temp_velocity.x < 0
		navigation_agent_2d.velocity = temp_velocity
	else:
		# 判断是否需要翻转鸡的方向
		#animatedPlayer.flip_h = target_direction.x < 0
		cow.velocity = target_direction * speed
		cow.move_and_slide()
	

# 触发避让速度计算后,使用安全速度移动
func on_safe_velocity_computed(safe_velocity:Vector2)->void:
	# 判断是否需要翻转鸡的方向
	# 安全避障后还需重新计算一下
	animatedPlayer.flip_h = safe_velocity.x < 0
	cow.velocity = safe_velocity
	cow.move_and_slide()
	

func _on_next_transitions()->void:
	do_decision()
	
# 决策 继续移动 还是 转为原地不动
func do_decision()->bool:
	if not navigation_agent_2d.is_navigation_finished():
		return false
	var walk = randi_range(0,1) == 0
	if walk:
		set_movement_target()
	else:
		cow.velocity = Vector2.ZERO
		transition.emit("idle")
		
	return true

func _on_enter()->void:
	animatedPlayer.play("walk")
	
	
func _on_exit()->void:
	animatedPlayer.stop()

	
