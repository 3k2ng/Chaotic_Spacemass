extends KinematicBody2D
class_name EndlessScreenObject

func _physics_process(delta: float) -> void:
	#
	if position.x < -8 :
		position.x += get_viewport_rect().size.x + 8
	if position.y < -8:
		position.y += get_viewport_rect().size.y + 8
	if position.x > get_viewport_rect().size.x + 8:
		position.x -= get_viewport_rect().size.x + 8
	if position.y > get_viewport_rect().size.y + 8:
		position.y -= get_viewport_rect().size.y + 8
