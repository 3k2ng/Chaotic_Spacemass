extends Area2D

export var mapNumber: String 

func _ready():
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton \
    and event.button_index == BUTTON_LEFT \
    and event.is_pressed():
        self.on_click()

func on_click():
    get_tree().change_scene("res://Demo"+mapNumber+".tscn")