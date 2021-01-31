extends Control

signal confirmed
signal cancelled

onready var _button_click := $ButtonClick


func _on_YesButton_pressed():
	_button_click.play()
	emit_signal("confirmed")
	queue_free()


func _on_NoButton_pressed():
	_button_click.play()
	emit_signal("cancelled")
	queue_free()
