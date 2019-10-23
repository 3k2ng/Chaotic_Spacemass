extends EndlessScreenObject

export var velocity: Vector2 = Vector2.ZERO
export var rotation_velocity: float = 0
export var bullet_rotation: float = 0
export var lifetime: float = 3.2

func _ready() -> void:
	bullet_rotation = Vector2.ZERO.angle_to_point(velocity) - PI/2
	rotation = bullet_rotation

func _process(delta: float) -> void:
	if lifetime > 0:
		lifetime -= delta
	else:
		queue_free()

func _physics_process(delta: float) -> void:
	rotation = bullet_rotation
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision != null:
		queue_free()