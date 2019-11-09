extends Spaceship

signal final 

export var player_number: String

var combo_timer_left: float
var combo_timer_right: float

var combo_limit_left: float = .3
var combo_limit_right: float = .3

var _final_scene := preload("res://src/Scenes/Final.tscn")

func _ready() -> void:
	self.connect("final",self,"_add_final_scene")
	combo_timer_left = 0
	combo_timer_right = 0

func _process(delta: float) -> void:
	left =  Input.is_action_pressed("left_" + player_number)
	right =  Input.is_action_pressed("right_" + player_number)
	shoot =  Input.is_action_just_pressed("shoot_" + player_number)
	
	if combo_timer_left > 0 and Input.is_action_just_pressed("left_" + player_number):
		speed_right = speed_limit * 2
		$Jump.play(0)
	
	if combo_timer_right > 0 and Input.is_action_just_pressed("right_" + player_number):
		speed_left = speed_limit * 2
		$Jump.play(0)
	
	if Input.is_action_just_pressed("left_" + player_number) and not combo_timer_left > 0:
		combo_timer_left = combo_limit_left
	elif not combo_timer_left > 0:
		combo_timer_left = 0
	else:
		combo_timer_left -= delta
	
	if Input.is_action_just_pressed("right_" + player_number) and not combo_timer_right > 0:
		combo_timer_right = combo_limit_right
	elif not combo_timer_right > 0:
		combo_timer_right = 0
	else:
		combo_timer_right -= delta
		
	if self.current_health <= 0:
		emit_signal("final")
		
func _add_final_scene():
	var newFinalScene = _final_scene.instance()
	newFinalScene.get_node("win_player"+player_number).show()
	self.get_parent().add_child(newFinalScene)