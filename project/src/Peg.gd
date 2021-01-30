class_name Peg
extends StaticBody2D

signal destroyed(level)

export var _health := 1

var _level := 0

func _ready():
	_level = _health

func hit():
	_health -= 1
	if _health <= 0:
		emit_signal("destroyed", _level)
		print("SQUISHED A PEG")
		queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 10, Color.green)
