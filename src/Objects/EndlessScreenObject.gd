extends KinematicBody2D
class_name EndlessScreenObject

export var border_gap: float = 32

func _physics_process(delta: float) -> void:
	#Border checking
	if position.x < - border_gap / scale.x:
		position.x += get_viewport_rect().size.x + 2 * border_gap / scale.x
	
	if position.y < - border_gap / scale.y:
		position.y += get_viewport_rect().size.y + 2 * border_gap / scale.y
	
	if position.x > get_viewport_rect().size.x + border_gap / scale.x:
		position.x -= get_viewport_rect().size.x + 2 * border_gap / scale.x
	
	if position.y > get_viewport_rect().size.y + border_gap / scale.y:
		position.y -= get_viewport_rect().size.y + 2 * border_gap / scale.y
