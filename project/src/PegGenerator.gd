extends Node2D

signal pegs_ready

const _Peg := preload("res://src/Peg.tscn")

export var max_patterns := 3
export var upgraded_pegs := 5
export var max_peg_health := 2

var positions := []

var _peg_patterns  := [
	preload("res://src/PegPatterns/Circle.tscn"),
	preload("res://src/PegPatterns/Square.tscn"),
	preload("res://src/PegPatterns/RotatedSquare.tscn"),
	preload("res://src/PegPatterns/HollowSquare.tscn"),
	preload("res://src/PegPatterns/HollowCircle.tscn"),
	preload("res://src/PegPatterns/Pyramid.tscn"),
	preload("res://src/PegPatterns/ReversePyramid.tscn")
]


func _ready():
	randomize()
	_generate_pegs()


func _generate_pegs():
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
			var peg = _Peg.instance()
			peg.position = p.get_global_transform().origin
			$Pegs.add_child(peg)
		
	var remaining_to_upgrade = upgraded_pegs
	while remaining_to_upgrade > 0:
		var index := randi() % $Pegs.get_child_count()
		var peg := $Pegs.get_child(index)
		if peg.health < max_peg_health:
			peg.health += 1
			remaining_to_upgrade -= 1

	emit_signal("pegs_ready")
