extends EndlessScreenObject

export var lifetime: float = 1.6
export var explosion: PackedScene

func _ready() -> void:
	rotation = Vector2.ZERO.angle_to_point(velocity) - PI/2

func _process(delta: float) -> void:
	if lifetime > 0:
		lifetime -= delta
	else:
		explode()

func _physics_process(delta: float) -> void:
	rotation = Vector2.ZERO.angle_to_point(velocity) - PI/2
	#Move and collide
	var collision: KinematicCollision2D = move_and_collide(velocity * scale.length() * delta / sqrt(2))
	if collision:
		if collision.collider.has_method("_hit"):
			collision.collider._hit(.75, velocity, collision.position)
		explode()

func explode():
	var expl = explosion.instance()
	expl.position = position
	expl.scale = scale / 4
	get_parent().add_child(expl)
	queue_free()
