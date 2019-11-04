extends Area2D

var scene : Node = Node.new()
var players := preload("res://src/Scenes/TwoPlayer.tscn")
export var packed : bool

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left-mouse") and packed:
		var pl = players.instance()
		var mp = self.duplicate()
		mp.packed = false
		mp.position = Vector2.ZERO
		mp.scale = Vector2.ONE
		scene.name = "Scene"
		scene.add_child(mp)
		scene.add_child(pl)
		get_parent().get_parent().add_child(scene)
		get_parent().queue_free()
		pass

func _mouse_entered():
	if packed:
		$AnimationPlayer.play("zoom_in")
	else:
		scale = Vector2.ONE

func _mouse_exited():
	if packed:
		$AnimationPlayer.play("zoom_out")
	else:
		scale = Vector2.ONE
