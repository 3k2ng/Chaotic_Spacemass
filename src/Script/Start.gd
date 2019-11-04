extends Area2D

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left-mouse"):
		get_tree().change_scene("res://MapSelect.tscn")

func _mouse_entered():
	$AnimationPlayer.play("zoom_in")

func _mouse_exited():
	$AnimationPlayer.play("zoom_out")