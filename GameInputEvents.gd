class_name GameInputEvents


static var dection:Vector2

static func movement_input()->Vector2:
	if Input.is_action_pressed("walk_left"):
		dection = Vector2.LEFT
	elif Input.is_action_pressed("walk_right"):
		dection = Vector2.RIGHT
	elif Input.is_action_pressed("walk_up"):
		dection = Vector2.UP
	elif Input.is_action_pressed("walk_down"):
		dection = Vector2.DOWN
	else:
		dection = Vector2.ZERO
	
	return dection
	
	

static func is_movement_input()->bool:
	return dection != Vector2.ZERO
	
	
static func use_tool() ->bool:
	return Input.is_action_pressed("Hit")
