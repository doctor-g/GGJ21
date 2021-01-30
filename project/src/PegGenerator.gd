extends Node2D

const _peg := preload("res://src/Peg.tscn")

export var _max_pegs := 20
export var _min_distance_between_pegs := 40.0

var _peg_positions := []

var _spawn_area_bounds := Vector2.ZERO

func _ready():
	randomize()
	_spawn_area_bounds = $SpawnArea/CollisionShape2D.shape.extents*2
	_generate_pegs()

func _generate_pegs():
	for _i in _max_pegs:
		var finding_pos := true
		var pos:Vector2
		while finding_pos:
			finding_pos = false
			var pos_x := rand_range(10, _spawn_area_bounds.x)
			var pos_y := rand_range(100, _spawn_area_bounds.y)
			pos = Vector2(pos_x, pos_y)
			for other_pos in _peg_positions:
				var distance_between_pegs := pos.distance_to(other_pos)
				if distance_between_pegs < _min_distance_between_pegs:
					finding_pos = true
					print("Too Close")
		_peg_positions.append(pos)
		var _Peg := _peg.instance()
		_Peg.position = pos
		$Pegs.add_child(_Peg)
