extends Node

signal score_changed(score)
signal lives_changed(lives)
signal chain_changed(chain)

var lives : int setget _set_lives

var _chain := 0 
var _score := 0 

func _ready():
	reset()

	
func reset():
	_score = 0
	lives = 3
	_chain = 0


func increase_chain()->void:
	_chain += 1
	emit_signal("chain_changed", _chain)
	

func reset_chain()->void:
	_chain = 0
	emit_signal("chain_changed", _chain)


# Add the given number of points, which will be scaled by the current multiplier.
func add_points(points:int)->void:
	_score += int(points * (1.0 + (_chain-1) * .1))
	emit_signal("score_changed", _score)


func get_score()->int:
	return _score
	

func _set_lives(value):
	lives = value
	emit_signal("lives_changed", lives)
