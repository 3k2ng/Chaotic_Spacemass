extends Node2D

signal pause

func _ready():
	pass 
	
func _process(delta):
	if Input.is_action_pressed("pause"):
		emit_signal("pause")
	


