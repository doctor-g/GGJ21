extends Control

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene("res://src/MainMenuScreen.tscn")
