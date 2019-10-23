#Inherit custom class
extends EndlessScreenObject

#Rotation speed
export var rotation_speed: float = 3.2
#Max speed (min speed = 0)
export var speed_limit: float = 512
#Cooldown
export var shoot_cd: float = .2
#Loading time
export var max_reloading_cd: float = 1.6
#Bullet import
export var bullet: PackedScene
#Maximum number of loaded bullets
export var max_bullets: int = 3

#Current speed
var speed: float = 0
#Current speed location (min if brake and max if not brake)
var speed_aim: float = 0
#Timer for countdown shots
var cd_timer: float = 0
#Timer for loading bullets
var reloading_timer: float = max_reloading_cd
#Current number of loaded bullets
var loaded_bullets: int = max_bullets


func _process(delta: float) -> void:
	#Increasing speed
	if abs(speed - speed_aim) >= 0 and Input.is_action_pressed("brake_0"):
		speed += (speed_aim - speed) * delta * 3.2
	elif abs(speed - speed_aim) >= 0:
		speed += (speed_aim - speed) * delta
	#Get input for rotation
	rotation += rotation_speed * (Input.get_action_strength("right_0") - Input.get_action_strength("left_0")) * delta * ((speed / speed_limit) * .2 + .8)
	#Change speed aim when brake
	if Input.is_action_pressed("brake_0"):
		speed_aim = 0
	else:
		speed_aim = speed_limit
	#Shoot
	if Input.is_action_pressed("shoot_0") and cd_timer <= 0 and loaded_bullets > 0:
		var new_bullet = bullet.instance()
		new_bullet.scale = scale
		new_bullet.position = position + Vector2.UP.rotated(rotation) * 48
		new_bullet.velocity = Vector2.UP.rotated(rotation) * speed_limit * 1.6
		get_parent().add_child(new_bullet)
		speed = -256
		cd_timer = shoot_cd
		loaded_bullets -= 1
		print_debug("Remaining bullets: ", loaded_bullets)
	#Shoot countdown timer
	if cd_timer > 0:
		cd_timer -= delta
	#Bullet reloading timer
	if reloading_timer > 0 and loaded_bullets < max_bullets:
		reloading_timer -= delta
	elif loaded_bullets < max_bullets:
		loaded_bullets += 1
		reloading_timer = max_reloading_cd
		print_debug("Remaining bullets: ", loaded_bullets)

func _physics_process(delta: float) -> void:
	#Move and slide
	move_and_slide(Vector2.UP.rotated(rotation) * speed)