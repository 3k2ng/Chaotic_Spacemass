extends MarginContainer

export var bullet : PackedScene

func _on_Player_check(health, bullets, shot_cd):
	for i in get_child(0).get_child(1).get_children():
		i.queue_free()
	get_child(0).get_child(0).value = health
	for i in range(bullets + 1):
		var new_bullet := bullet.instance()
		if i == bullets:
			new_bullet.value = 1 - shot_cd
		get_child(0).get_child(1).add_child(new_bullet)
	if health <= 0:
		queue_free()
