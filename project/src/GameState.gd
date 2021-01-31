extends Node

signal score_changed(score)
signal lives_changed(lives)
signal chain_changed(chain)

const CONFIG_PATH = "user://settings.cfg"

var lives : int setget _set_lives

var _chain := 0 
var _score := 0 
var highscore := 0
var unlock_level := 0 setget _set_unlock_level
var new_unlock := false
var animal_index := 0

var config : ConfigFile = ConfigFile.new()


func _ready():
	reset()
	var err = config.load(CONFIG_PATH)
	if err == OK:
		highscore = config.get_value("save", "highscore", 0)
		unlock_level = config.get_value("save", "unlock_level", 0)

	
func reset():
	_score = 0
	lives = 3
	_chain = 0
	new_unlock = false


func _set_unlock_level(value):
	unlock_level = value
	config.set_value("save", "unlock_level", value)
	save_config()


func save_config():
	config.save(CONFIG_PATH)


func reset_config():
	unlock_level = 0
	highscore = 0
	config.set_value("save", "unlock_level", 0)
	config.set_value("save", "highscore", 0)
	save_config()


func get_chain()->int:
	return _chain


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
	
	if _score > highscore:
		highscore = _score
		config.set_value("save", "highscore", _score)
	
	if not new_unlock and _has_unlocked_next_animal():
		print('UNLOCKED NEW THING')
		new_unlock = true
	

func _has_unlocked_next_animal()->bool:
	if unlock_level+1 < AnimalSettings.ANIMALS.size():
		return _score >= AnimalSettings.ANIMALS[unlock_level+1].score
	else:
		return false


func get_score()->int:
	return _score
	

func _set_lives(value):
	lives = value
	emit_signal("lives_changed", lives)
