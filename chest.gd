extends Node2D

@onready var interoperable: Interoperable = $Interoperable
@onready var button: Button = $Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var feed_component: FeedComponent = $FeedComponent
@onready var reward_marker: Marker2D = $RewardMarker

@export var dialogue_start_command:String = "start"
@export var food_drop_height: int = 40
@export var reward_output_radius: int =  50
@export var output_reward_scenes: Array[PackedScene]

# 奖励物品的抛物线高度
@export var parabola_height: int =  25



var in_range: bool

var balloon_Scene = preload("res://dialogue/game_dialogue_ballon.tscn")

var wheat_scene = preload("res://collectable_wheat.tscn")
var egg_plant_scene = preload("res://collectable_eggplant.tscn")
var milk_scene = preload("res://collectable_milk.tscn")

func _ready() -> void:
	interoperable.interaction_activited.connect(on_interaction_activited)
	interoperable.interaction_leave.connect(on_interaction_leave)
	GameDialogueManager.close_chest.connect(on_close_chest)
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)
	
	feed_component.feed_received.connect(on_feed_received)
	button.hide() 

func on_close_chest() -> void:
	pass
	
func on_interaction_activited(body: Node2D) -> void:
	button.show()
	in_range = true



func on_interaction_leave(body: Node2D) -> void:
	button.hide()
	in_range = false
	animation_player.play("chest_close")

# 触发喂食
func on_feed_the_animals() -> void:
	if in_range:
		trigger_feed_harvest("wheat",wheat_scene)
		

# 触发喂养
func trigger_feed_harvest(inventory_item: String, scene: Resource) -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if !inventory.has(inventory_item):
		return
	
	var item_count = inventory[inventory_item]
	for index in item_count:
		# 获取喂养的库存,实例化,放置到宝箱上方
		var instance = scene.instantiate() as Node2D
		close_collectable_float_shadow(instance)
		instance.global_position = Vector2(global_position.x,global_position.y-food_drop_height)
		get_tree().root.add_child(instance)
	
	
		# 创建一个计时器,0.4,2秒开始执行
		var target_position = global_position
		var time_delay = randf_range(0.5,1.0)
		await get_tree().create_timer(time_delay).timeout
		
		# 创建补间动画, 移动并缩小 库存物品,当碰到宝箱时,进行销毁
		var tween = get_tree().create_tween()
		tween.tween_property(instance,"position",target_position,1.0)
		tween.tween_property(instance,"scale",Vector2(0.5,0.5),1.0)
		
		# 回调
		tween.tween_callback(instance.queue_free)
		InventoryManager.remove_inventory(inventory_item)
		

# 关闭可拾取物品的浮动效果
func close_collectable_float_shadow(node: Node2D) -> void:
	for child in node.get_children():
		if child is FloatShadow:
			var c = child as FloatShadow
			c.enable_animals = false

	

# 当宝箱"吃掉"库存物品后,添加奖励物品
func on_feed_received() -> void:
	call_deferred("add_reward_scene")
	
func add_reward_scene() -> void:
	for scene in output_reward_scenes:
		var reward = scene.instantiate()
		close_collectable_float_shadow(reward)
		var reward_position: Vector2 = get_random_position_in_circle(reward_marker.global_position,reward_output_radius)
		reward.global_position = global_position
		var tween:Tween = get_tree().create_tween()
		
		var mid_point = Vector2((global_position.x + reward_position.x) / 2, global_position.y - parabola_height)
		
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(reward, "position", mid_point, 1)
		tween.tween_property(reward, "position", reward_position, 1)
		#tween.start()
		get_tree().root.add_child(reward)
		#reward.global_position = reward_position
		
		

# 随机获取圆中的坐标
func get_random_position_in_circle(center: Vector2, radius: int) -> Vector2i:
	var angle = randf() * TAU
	
	var distance_from_center = sqrt(randf()) * radius 
	var x: int = center.x + distance_from_center * cos(angle)
	var y: int = center.y  + distance_from_center * cos(angle)
	return Vector2i(x,y)
	
	
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("guide") && in_range:
		# 创建对话框
		var balloon: BaseGameDialogueBalloon = balloon_Scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		
		# 播放打开宝箱
		animation_player.play("chest_open")
		# 运行对话内容
		balloon.start(load("res://chest.dialogue"),dialogue_start_command)
		
		# 暂停当前页面活动
		GameDialogueManager.stop_world()	
