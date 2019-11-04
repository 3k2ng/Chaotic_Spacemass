extends Area2D

var scene : Node = Node.new()
var players := preload("res://src/Scenes/TwoPlayer.tscn")
var map := preload("res://src/Maps/Map_1.tscn")

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left-mouse"):
		scene.name = "Scene"
#		get_tree().change_scene("res://MapSelect.tscn")
		scene.add_child(map.instance())
		scene.add_child(players.instance())
		get_parent().get_parent().add_child(scene)
		get_parent().queue_free()
		pass

func _mouse_entered():
	$AnimationPlayer.play("zoom_in")

func _mouse_exited():
	$AnimationPlayer.play("zoom_out")