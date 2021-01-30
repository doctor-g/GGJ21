extends Control

signal dismissed

func _on_PlayAgainButton_pressed():
	emit_signal("dismissed")
