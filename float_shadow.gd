# 用于增加浮动阴影效果
class_name FloatShadow
extends Node2D
 
# 浮动最大高度
@export var float_max_high:int = 5
# 浮动升高速度
@export var float_high_speed:int = 5
# 阴影的高度
@export var shadow_high:float = -4
# 阴影浮动的速度
@export var shadow_high_speed:float = 8.0

@export var sprite2D: Sprite2D

@export var shadow_blur_mount:float = 1
@export var shadow_blur_mount_speed:float = 2.5

var enable_animals = true

# 是否升高动画
var need_high:bool = true

# 是否开启阴影
var enable_shadow = false

# 父节点初始高度
var current_parent_position_y: float

# 父节点浮动所至最大高度
var current_parent_position_max_y:float

func _ready() -> void:
	if not is_node_ready():
		await ready
		
	_init_shadow()

func _init_shadow() -> void:
	current_parent_position_y = sprite2D.position.y
	current_parent_position_max_y = current_parent_position_y-float_max_high
	enable_shadow = true

func _process(delta: float) -> void:
	if !enable_animals:
		return
		
	var tempMaterial
	if  sprite2D.material:
		tempMaterial = sprite2D.material as ShaderMaterial
	
	if need_high:
		# 1, -3 
		sprite2D.position.y = sprite2D.position.y - delta * float_high_speed
		need_high = sprite2D.position.y >= current_parent_position_max_y
		
		# 升高时: 距离变远, 阴影变小变淡
		if tempMaterial and enable_shadow:
			shadow_high = shadow_high - delta * shadow_high_speed
			shadow_blur_mount = shadow_blur_mount + delta * shadow_blur_mount_speed
			tempMaterial.set_shader_parameter("shadow_offset",Vector2(0,shadow_high))
			tempMaterial.set_shader_parameter("blur_amount",shadow_blur_mount)


	else:
		sprite2D.position.y = sprite2D.position.y + delta * float_high_speed
		need_high = sprite2D.position.y >= current_parent_position_y
		
		# 下降时,距离变近,阴影越大,越清晰
		if tempMaterial and enable_shadow:
			shadow_high = shadow_high + delta * shadow_high_speed
			shadow_blur_mount = shadow_blur_mount-delta * shadow_blur_mount_speed
			tempMaterial.set_shader_parameter("shadow_offset",Vector2(0,shadow_high))
			tempMaterial.set_shader_parameter("blur_amount",shadow_blur_mount)
		
	
