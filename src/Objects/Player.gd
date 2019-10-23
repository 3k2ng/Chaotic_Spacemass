extends EndlessScreenObject

#Current speed
var speed: float = 0
#Current speed location (min if brake and max if not brake)
var speed_aim: float = 0
#Timer
var cd_timer: float = 0
#Velocity rotation and sprite rotation combined
export var ship_rotation: float = 0
#Rotation speed
export var rotation_speed: float = 3.2
#Max speed (min speed = 0)
export var speed_limit: float = 512
#Cooldown
export var shoot_cd: float = .2
#Bullet import
var Bullet = preload("./Bullet.tscn")



func _process(delta: float) -> void:
	#Increasing speed
	if abs(speed - speed_aim) >= 0 and Input.is_action_pressed("brake_0"):
		speed += (speed_aim - speed) * delta * 3.2
	elif abs(speed - speed_aim) >= 0:
		speed += (speed_aim - speed) * delta
	#Get input for rotation
	ship_rotation += rotation_speed * (Input.get_action_strength("right_0") - Input.get_action_strength("left_0")) * delta * ((speed / speed_limit) * .2 + .8)
	#Change speed aim when brake
	if Input.is_action_pressed("brake_0"):
		speed_aim = 0
	else:
		speed_aim = speed_limit
	
	if Input.is_action_pressed("shoot_0") and cd_timer <= 0:
		var new_bullet = Bullet.instance()
		new_bullet.position = position + Vector2.UP.rotated(ship_rotation) * 48
		new_bullet.velocity = Vector2.UP.rotated(ship_rotation) * speed_limit * 1.6
		get_parent().add_child(new_bullet)
		speed = -256
		cd_timer = shoot_cd
	
	if cd_timer > 0:
		cd_timer -= delta



func _physics_process(delta: float) -> void:
	#Rotate
	rotation = ship_rotation
	#Move and slide
	move_and_slide(Vector2.UP.rotated(ship_rotation) * speed)