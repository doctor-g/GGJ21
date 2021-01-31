extends Control

signal confirmed
signal cancelled


func _on_YesButton_pressed():
	emit_signal("confirmed")
	queue_free()


func _on_NoButton_pressed():
	emit_signal("cancelled")
	queue_free()
