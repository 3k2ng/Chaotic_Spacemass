extends Sprite

var lifetime = 1

func _ready() -> void:
	get_child(0).play("Fade")
	$Explosion.volume_db = -sqrt(2) / scale.length()
	$Explosion.play(0)

func _process(delta: float) -> void:
	if lifetime > 0:
		lifetime -= delta
	else:
		queue_free()