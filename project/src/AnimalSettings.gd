extends Node

const _ANIMAL_SEQUENCE = [
	"chick",
	"goat",
	"bear",
	"buffalo",
	"dog",
	"duck",
	"elephant",
	"gorilla",
	"hippo",
	"horse",
	"monkey",
	"moose",
	"narwhal",
	"panda",
	"pig",
	"rabbit",
	"snake",
	"zebra",
	"penguin",
	"rhino"
]

var ANIMALS = _make_animals_conf()

func _make_animals_conf()->Array:
	var result = []
	var count = 0
	for animal in _ANIMAL_SEQUENCE:
		result.append({
			"image": _asset(animal),
			"score": 200 * count
		})
		count += 1
	return result


func _asset(name):
	return load("res://assets/animals/%s.png" % name)
