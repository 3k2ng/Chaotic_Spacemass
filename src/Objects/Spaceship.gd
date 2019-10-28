#Inherit custom class
extends EndlessScreenObject

class_name Spaceship

#Signals
signal check

#Control turned into bool for AI to use
var left: bool
var right: bool
var shoot: bool

#Invincible timer
var invin_timer: float

#Max speed (min speed = 0)
export var speed_limit: float = 320

#Cooldown
export var shoot_cd: float = .2
#Loading time
export var max_reloading_cd: float = 3.2
#Bullet import
export var bullet: PackedScene

export var explosion: PackedScene
#Maximum number of loaded bullets
export var max_bullets: int = 3

#Max health
export var max_health: float = 1
#Regen speed
export var regen_speed: float = .1

#Velocity, extra_force and rotating speed
var extra_force: Vector2
var extra_rotation: float
var rotating_speed: float
#Current speed
var speed_left: float
var speed_right: float
#Current speed location (min if brake and max if not brake)
var speed_aim_left: float
var speed_aim_right: float

#Timer for countdown shots
var cd_timer: float = 0
#Timer for loading bullets
var reloading_timer: float
#Current number of loaded bullets
var loaded_bullets: int

#Current health
var current_health: float

#Sprites
onready var left_engine_sprite = $BurstSpriteLeft
onready var right_engine_sprite = $BurstSpriteRight

func _hit(damage: float, hit:= Vector2.ZERO, hit_pos:= position) -> void:
	if invin_timer > 0:
		return
	#Calculte the hit
	current_health -= damage
	var dis:= position - hit_pos
	var deg:= - dis.angle_to(hit)
	extra_rotation += (hit - velocity).length() * sin(deg) / (3.2 * dis.length())
	extra_force += hit.length() * cos(deg) * dis.normalized() * .64
	speed_left = 0
	speed_right = 0
	invin_timer += 1.6

func _ready() -> void:
	#Initializing values
	#Speed values
	velocity = Vector2.ZERO
	rotating_speed = 0
	speed_left = 0
	speed_right = 0
	speed_aim_left = 0
	speed_aim_right = 0
	extra_force = Vector2.ZERO
	extra_rotation = 0
	#Timers and shots
	cd_timer = 0
	reloading_timer = max_reloading_cd
	loaded_bullets = max_bullets
	invin_timer = 3.2
	#Health
	current_health = max_health
	

func _process(delta: float) -> void:
	
	#Controling engines
	#Left engine
	if left:
		speed_aim_left = 0
	else:
		speed_aim_left = speed_limit
	#Right engine
	if right:
		speed_aim_right = 0
	else:
		speed_aim_right = speed_limit
		
	#Altering speed of two engines
	#Left engine
	if abs(speed_left - speed_aim_left) > 0 and left:
		speed_left += (speed_aim_left - speed_left) * delta * 3.2
	elif abs(speed_left - speed_aim_left) > 0:
		speed_left += (speed_aim_left - speed_left) * delta
	left_engine_sprite.scale.y = speed_left / speed_limit * .5
	#Right engine
	if abs(speed_right - speed_aim_right) > 0 and right:
		speed_right += (speed_aim_right - speed_right) * delta * 3.2
	elif abs(speed_right - speed_aim_right) > 0:
		speed_right += (speed_aim_right - speed_right) * delta
	right_engine_sprite.scale.y = speed_right / speed_limit * .5
	
	#Calculate rotation and velocity
	var forward_speed: float = 2 * min(speed_left, speed_right)
	var remaining_speed: float = max(speed_left, speed_right) - min(speed_left, speed_right)
	velocity = Vector2.UP * (forward_speed + remaining_speed * .32)
	if speed_left >= speed_right:
		rotating_speed = remaining_speed / 40
		velocity += Vector2.RIGHT * remaining_speed * .32
	else:
		rotating_speed = - remaining_speed /40
		velocity += Vector2.LEFT * remaining_speed * .32
	velocity = velocity.rotated(rotation) + extra_force
	rotating_speed += extra_rotation
	extra_force -= extra_force * delta * 3.2
	extra_rotation -= extra_rotation * delta * 3.2
	
	#Shoot
	if shoot and cd_timer <= 0 and loaded_bullets > 0:
		var new_bullet = bullet.instance()
		new_bullet.scale = scale
		new_bullet.position = position + Vector2.UP.rotated(rotation) * scale.length() * 32
		new_bullet.velocity = (Vector2.UP.rotated(rotation) * speed_limit * 3.2).rotated(rotating_speed * delta)
		speed_left = 0
		speed_right = 0
		extra_force -= new_bullet.velocity / 1.6
		get_parent().add_child(new_bullet)
		cd_timer = shoot_cd
		loaded_bullets -= 1
	#Shoot countdown timer
	if cd_timer > 0:
		cd_timer -= delta
	#Bullet reloading timer
	if reloading_timer > 0 and loaded_bullets < max_bullets:
		reloading_timer -= delta
	elif loaded_bullets < max_bullets:
		loaded_bullets += 1
		reloading_timer = max_reloading_cd
	
	if loaded_bullets >= max_bullets and current_health < max_health:
		current_health += regen_speed * delta
		if current_health > max_health:
			current_health = max_health
	
	if current_health <= 0:
		_die()
	
	if invin_timer > 0:
		$PlayerAnimPl.play("Flick")
		invin_timer -= delta
	else:
		invin_timer = 0
	
	emit_signal("check", current_health, loaded_bullets, reloading_timer/ max_reloading_cd)

func _physics_process(delta: float) -> void:
	rotation += rotating_speed * delta
	#Move and collide
	move_and_slide(velocity * scale.length() / sqrt(2))

func _die():
	var expl = explosion.instance()
	expl.position = position
	expl.scale = scale
	get_parent().add_child(expl)
	queue_free()