extends Sprite

var lifetime = .5

func _ready() -> void:
	get_child(0).play("Fade")

func _process(delta: float) -> void:
	if lifetime > 0:
		lifetime -= delta
	else:
		queue_free()