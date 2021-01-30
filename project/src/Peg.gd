class_name Peg
extends StaticBody2D

signal destroyed()

export var _health := 1


func hit():
	_health -= 1
	if _health <= 0:
		emit_signal("destroyed")
		queue_free()


func _draw():
	draw_circle(Vector2.ZERO, 10, Color.green)
