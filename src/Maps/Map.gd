extends Area2D

var scene : Node = Node.new()
var players := preload("res://src/Scenes/TwoPlayer.tscn")
var pause_scene := preload("res://src/Scenes/Pause.tscn")
export var packed : bool
export var start: bool = false

func _ready():
	pass
	
#func _add_final_scene( _player_lose ):
#	print_debug(_player_lose)

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left-mouse") and packed:
		start = true
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
#		self.get_parent().get_node("TwoPlayer").get_node("Player_1").connect("final",self,"_add_final_scene")
		
		pass
		
func _process(delta):
	if Input.is_action_pressed("pause"):
		var the_pause = pause_scene.instance()
		get_parent().add_child(the_pause)
		get_tree().paused = true


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
