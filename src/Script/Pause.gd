extends Area2D



func _process(delta):
	if Input.is_action_pressed("left-mouse"):
		get_tree().paused = false
		get_parent().queue_free()


func _pause_mouse_entered():
	print_debug("ENTER")
	$AnimationPlayer.play("pause-zoom-in")

func _pause_mouse_exited():
	$AnimationPlayer.play("pause-zoom-out")
