extends Node2D

func _on_TestScene_pause():
	get_tree().paused = true
	self.show()
	pass
