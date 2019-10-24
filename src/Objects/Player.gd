#Inherit custom class
extends EndlessScreenObject

#Max speed (min speed = 0)
export var speed_limit: float = 256

#Cooldown
export var shoot_cd: float = .2
#Loading time
export var max_reloading_cd: float = 1.6
#Bullet import
export var bullet: PackedScene
#Maximum number of loaded bullets
export var max_bullets: int = 3

#Velocity and rotating speed
var velocity: Vector2 = Vector2.ZERO
var rotating_speed: float = 0
#Current speed
var speed_left: float = 0
var speed_right: float = 0
#Current speed location (min if brake and max if not brake)
var speed_aim_left: float = 0
var speed_aim_right: float = 0

#Timer for countdown shots
var cd_timer: float = 0
#Timer for loading bullets
var reloading_timer: float = max_reloading_cd
#Current number of loaded bullets
var loaded_bullets: int = max_bullets

#Sprites
onready var left_engine_sprite = $BurstSpriteLeft
onready var right_engine_sprite = $BurstSpriteRight

func _process(delta: float) -> void:
	
	#Controling engines
	#Left engine
	if Input.is_action_pressed("left_0"):
		speed_aim_left = 0
	else:
		speed_aim_left = speed_limit
	#Right engine
	if Input.is_action_pressed("right_0"):
		speed_aim_right = 0
	else:
		speed_aim_right = speed_limit
		
	#Altering speed of two engines
	#Left engine
	if abs(speed_left - speed_aim_left) > 0 and Input.is_action_pressed("left_0"):
		speed_left += (speed_aim_left - speed_left) * delta * 3.2
	elif abs(speed_left - speed_aim_left) > 0:
		speed_left += (speed_aim_left - speed_left) * delta
	left_engine_sprite.scale.y = .1 + .7 * (speed_left/speed_limit)
	#Right engine
	if abs(speed_right - speed_aim_right) > 0 and Input.is_action_pressed("right_0"):
		speed_right += (speed_aim_right - speed_right) * delta * 3.2
	elif abs(speed_right - speed_aim_right) > 0:
		speed_right += (speed_aim_right - speed_right) * delta
	right_engine_sprite.scale.y = .1 + .7 * (speed_right/speed_limit)
	#Calculate rotation and velocity
	var forward_speed: float = 2 * min(speed_left, speed_right)
	var remaining_speed: float = max(speed_left, speed_right) - min(speed_left, speed_right)
	velocity = Vector2.UP * forward_speed
	if speed_left >= speed_right:
		rotating_speed = remaining_speed * .6 / 48
		velocity += Vector2.RIGHT * remaining_speed * .2
	else:
		rotating_speed = - remaining_speed * .6 / 48
		velocity += Vector2.LEFT * remaining_speed * .2
	#Shoot
	if Input.is_action_pressed("shoot_0") and cd_timer <= 0 and loaded_bullets > 0:
		var new_bullet = bullet.instance()
		new_bullet.scale = scale
		new_bullet.position = position + Vector2.UP.rotated(rotation) * 48
		new_bullet.velocity = Vector2.UP.rotated(rotation) * speed_limit * 2
		speed_left -= speed_limit / 2
		speed_right -= speed_limit / 2
		get_parent().add_child(new_bullet)
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
	rotation += rotating_speed * delta
	move_and_slide(velocity.rotated(rotation))