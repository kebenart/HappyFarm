class_name GameInputEvents


static var dection:Vector2

static func movement_input()->Vector2:
	if Input.is_action_pressed("ui_left"):
		dection = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		dection = Vector2.RIGHT
	elif Input.is_action_pressed("ui_up"):
		dection = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		dection = Vector2.DOWN
	else:
		dection = Vector2.ZERO
	
	return dection
	
	

static func is_movement_input()->bool:
	return dection != Vector2.ZERO
