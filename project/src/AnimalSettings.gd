extends Node

const _ANIMAL_BG_SEQUENCE = [
	"chick", "farm",
	"goat", "farm",
	"bear", "forest",
	"buffalo", "serengeti",
	"dog", "forest",
	"duck", "farm",
	"elephant", "serengeti",
	"gorilla", "jungle",
	"walrus", "water",
	"horse", "farm",
	"monkey", "jungle",
	"moose", "forest",
	"narwhal", "water",
	"panda", "jungle",
	"pig", "farm",
	"rabbit", "forest",
	"snake", "jungle",
	"zebra", "serengeti",
	"penguin", "water",
	"rhino", "serengeti"
]

var ANIMALS = _make_animals_conf()

func _make_animals_conf()->Array:
	var result = []
	var count = 0
	for i in range(0, _ANIMAL_BG_SEQUENCE.size(), 2):
		var animal : String = _ANIMAL_BG_SEQUENCE[i]
		var background : String = _ANIMAL_BG_SEQUENCE[i+1]
		result.append({
			"image": _asset(animal),
			"score": 200 * count,
			"background": _background(background)
		})
		count += 1
	return result


func _asset(name):
	return load("res://assets/animals/%s.png" % name)


func _background(name):
	return load("res://assets/backgrounds/%s_background.png" % name)
