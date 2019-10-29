extends Spaceship

export var player_number: String

func _physics_process(delta: float) -> void:
	left =  Input.is_action_pressed("left_" + player_number)
	right =  Input.is_action_pressed("right_" + player_number)
	shoot =  Input.is_action_just_pressed("shoot_" + player_number)