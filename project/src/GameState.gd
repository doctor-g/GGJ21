extends Node

signal score_changed(score)
signal lives_changed(lives)

var score := 0 setget _set_score
var lives : int setget _set_lives


func _ready():
	reset()

	
func reset():
	score = 0
	lives = 3


func _set_score(value):
	score = value
	emit_signal("score_changed", score)
	

func _set_lives(value):
	lives = value
	emit_signal("lives_changed", lives)
