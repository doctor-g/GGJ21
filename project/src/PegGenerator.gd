extends Node2D

signal pegs_ready

const _Peg := preload("res://src/Peg.tscn")

export var max_patterns := 6
export var upgraded_pegs := 5
export var max_peg_health := 2

var positions := []
var _dense_peg_patterns  := [
	preload("res://src/PegPatterns/Circle.tscn"),
	preload("res://src/PegPatterns/Square.tscn"),
	preload("res://src/PegPatterns/RotatingSquare.tscn"),
	preload("res://src/PegPatterns/RotatedSquare.tscn"),
	preload("res://src/PegPatterns/RotatingCircle.tscn"),
	preload("res://src/PegPatterns/DenseCircle.tscn"),
	preload("res://src/PegPatterns/RotatingDenseCircle.tscn"),
	preload("res://src/PegPatterns/RotatingCircle.tscn"),
	preload("res://src/PegPatterns/DenseWave.tscn"),
]
var _light_peg_patterns := [
	preload("res://src/PegPatterns/HollowSquare.tscn"),
	preload("res://src/PegPatterns/RotatingHollowSquare.tscn"),
	preload("res://src/PegPatterns/HollowCircle.tscn"),
	preload("res://src/PegPatterns/RotatingHollowCircle.tscn"),
	preload("res://src/PegPatterns/Pyramid.tscn"),
	preload("res://src/PegPatterns/ReversePyramid.tscn"),
	preload("res://src/PegPatterns/Wave.tscn"),
	preload("res://src/PegPatterns/Rhombus.tscn"),
]
var _peg_patterns := []


func _ready()->void:
	randomize()
	_get_pattern_level()
	_set_peg_level()
	_generate_pegs()


func _get_pattern_level()->void:
	var unlock_level := GameState.unlock_level
	if unlock_level < 3:
		add_patterns(_light_peg_patterns)
		#max_patterns = 4
	elif unlock_level > 2 and unlock_level < 5:
		add_patterns(_light_peg_patterns)
		add_patterns(_dense_peg_patterns)
	else:
		add_patterns(_dense_peg_patterns)
#	if unlock_level > 2 and unlock_level < 4:
#		max_patterns = 5


func add_patterns(patterns:Array)->void:
	for pattern in patterns:
		_peg_patterns.append(pattern)


func _set_peg_level()->void:
	var unlock_level := GameState.unlock_level
	upgraded_pegs = unlock_level + 5
	if unlock_level > 3:
		max_peg_health = 3


func _generate_pegs()->void:
	for _i in range(0,max_patterns):
		var pattern_index = randi()%_peg_patterns.size()
		var Pattern = _peg_patterns[pattern_index]
		var pattern:Node2D = Pattern.instance()
		var pos_not_found := true
		while pos_not_found:
			var pos:Vector2 = $Positions.get_child(randi()%$Positions.get_child_count()).get_global_transform().origin
			if not positions.has(pos):
				pattern.position = pos
				positions.append(pos)
				pos_not_found = false
		add_child(pattern)
		for p in pattern.get_children():
			if p is Position2D:
				var peg = _Peg.instance()
				peg.base_position = p
				$Pegs.add_child(peg)
		
	var remaining_to_upgrade = upgraded_pegs
	while remaining_to_upgrade > 0:
		var index := randi() % $Pegs.get_child_count()
		var peg := $Pegs.get_child(index)
		if peg.health < max_peg_health:
			peg.health += 1
			remaining_to_upgrade -= 1

	emit_signal("pegs_ready")
