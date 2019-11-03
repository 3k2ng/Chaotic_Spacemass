extends Area2D

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
        self.on_click()

func on_click():
	get_tree().change_scene("res://MapSelection.tscn")
#
#func _process(delta):
#	if Input.is_action_pressed("left-mouse"):
#		get_tree().change_scene("res://MapSelection.tscn")

#func _mouse_enter():
#	pass

#func _on_Area2D_area_entered(area):
#	get_tree().change_scene("res://MapSelection.tscn")
#	pass # Replace with function body.
