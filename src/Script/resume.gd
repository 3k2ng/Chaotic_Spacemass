extends Area2D

#func _input_event(viewport, event, shape_idx):
#    if event is InputEventMouseButton \
#    and event.button_index == BUTTON_LEFT \
#    and event.is_pressed():
#        get_tree().paused = false
##		self.get_parent().hide()

#func on_click():
#	print_debug("click")
#	get_tree().paused = false
#	self.get_parent().hide()

func _process(delta):
	if Input.is_action_pressed("left-mouse"):
		get_tree().paused = false
		self.get_parent().hide()