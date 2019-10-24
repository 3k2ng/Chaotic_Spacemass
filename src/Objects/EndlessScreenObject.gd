extends KinematicBody2D
class_name EndlessScreenObject

func _physics_process(delta: float) -> void:
	#
	if position.x < 0:
		position.x += get_viewport_rect().size.x
	if position.y < 0:
		position.y += get_viewport_rect().size.y
	if position.x > get_viewport_rect().size.x:
		position.x -= get_viewport_rect().size.x
	if position.y > get_viewport_rect().size.y:
		position.y -= get_viewport_rect().size.y
