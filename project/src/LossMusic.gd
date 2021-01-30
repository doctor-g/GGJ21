extends AudioStreamPlayer

const THEME = preload("res://assets/music/theme.ogg")


func _on_LossMusic_finished():
	yield(get_tree().create_timer(1.5), "timeout")
	stream = THEME
	play()
