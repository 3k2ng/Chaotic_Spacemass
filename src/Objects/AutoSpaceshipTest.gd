extends Spaceship

var location: Vector2

var speed_control_left: float = 1

var speed_control_right: float = 1

var general_speed: float = 1

func _process(delta: float) -> void:
	location = get_viewport().get_mouse_position()
	
	var dis := location - position - velocity.normalized() * (scale.length() / sqrt(2)) * 32
	if dis.x > get_viewport_rect().size.x / 2:
		location.x -= get_viewport_rect().size.x + border_gap * (scale.length() / sqrt(2))
	if dis.y > get_viewport_rect().size.y / 2:
		location.y -= get_viewport_rect().size.y + border_gap * (scale.length() / sqrt(2))
	if dis.x < -get_viewport_rect().size.x / 2:
		location.x += get_viewport_rect().size.x + border_gap * (scale.length() / sqrt(2))
	if dis.y < -get_viewport_rect().size.y / 2:
		location.y += get_viewport_rect().size.y + border_gap * (scale.length() / sqrt(2))
	
	dis = location - position - velocity.normalized() / (scale.length() / sqrt(2)) * 32
	
	general_speed = min(1, (dis.length() / scale.length()) / 128)
	if general_speed < .064:
		general_speed = 0
	
	if speed_left > speed_limit * speed_control_left:
		left = true
	else:
		left = false
	
	if speed_right > speed_limit * speed_control_right:
		right = true
	else:
		right = false
	
	if velocity.angle_to(dis) < 0:
		speed_control_right = general_speed
		speed_control_left = max(0,cos(velocity.angle_to(dis))) * general_speed
	elif velocity.angle_to(dis) > 0:
		var go_left := 1 - cos(velocity.angle_to(dis))
		speed_control_right = max(0,cos(velocity.angle_to(dis))) * general_speed
		speed_control_left = general_speed
	
	shoot = Input.is_mouse_button_pressed(BUTTON_LEFT)