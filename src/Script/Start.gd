extends Area2D

var scene : Node = Spatial.new()
var players := preload("res://src/Scenes/TwoPlayer.tscn")
var map := preload("res://src/Maps/Map_1.tscn")

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left-mouse"):
#		get_tree().change_scene("res://MapSelect.tscn")
		scene.add_child(map.instance())
		scene.add_child(players.instance())
		get_parent().add_child(scene)
		queue_free()
		pass
