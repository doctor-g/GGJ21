extends Control

signal dismissed


func show():
	visible = true

	
func _input(event):
	if visible and event is InputEventMouseButton and event.is_pressed():
		emit_signal("dismissed")
