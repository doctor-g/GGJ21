extends AudioStreamPlayer

onready var THEME = preload("res://assets/music/theme.ogg")

func _on_Music_finished():
	stream = THEME
	play()
