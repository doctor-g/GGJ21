class_name Peg
extends StaticBody2D

signal destroyed()

export var health := 1

onready var _colored_part := $PegBackground
onready var _tween := $Tween

var _health_colors := [Color.blue, Color.orange, Color.red]

func _ready():
	_colored_part.modulate = _health_colors[health-1]

func hit():
	health -= 1
	if health > 0:
		var next_color:Color = _health_colors[health-1]
		_tween.interpolate_property(_colored_part, "modulate", null, next_color, 0.5)
		_tween.start()
	if health <= 0:
		emit_signal("destroyed")
		queue_free()


func _draw():
	draw_circle(Vector2.ZERO, 10, Color.green)
