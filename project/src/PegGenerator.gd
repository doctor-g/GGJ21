extends Node2D

signal peg_destroyed
signal pegs_ready(pegs)

const _peg := preload("res://src/Peg.tscn")

export var _max_pegs := 3.0
export var _min_distance_between_pegs := 40.0
export var _percent_of_upgraded_pegs := 33.0

var _peg_positions := []
var _upgraded_pegs:int = 0

var _spawn_area_offset := Vector2.ZERO
var _spawn_area_bounds := Vector2.ZERO

func _ready():
	randomize()
	_percent_of_upgraded_pegs /= 100
	_upgraded_pegs = ceil(_max_pegs*_percent_of_upgraded_pegs)
	var _spawn_area : Vector2 = $SpawnArea/CollisionShape2D.shape.extents*2
	_spawn_area_offset = (get_viewport_rect().size-_spawn_area)/2
	_spawn_area_bounds = _spawn_area
	_generate_pegs()

func _generate_pegs():
	for _i in _max_pegs:
		var finding_pos := true
		var pos:Vector2
		while finding_pos:
			finding_pos = false
			var pos_x := rand_range(_spawn_area_offset.x, _spawn_area_bounds.x)
			var pos_y := rand_range(_spawn_area_offset.y, _spawn_area_bounds.y)
			pos = Vector2(pos_x, pos_y)
			for other_pos in _peg_positions:
				var distance_between_pegs := pos.distance_to(other_pos)
				if distance_between_pegs < _min_distance_between_pegs:
					finding_pos = true
					print("Too Close")
		_peg_positions.append(pos)
		var _Peg := _peg.instance()
		if _upgraded_pegs > 0:
			_upgraded_pegs -= 1
			_Peg.health = 3
		_Peg.position = pos
		$Pegs.add_child(_Peg)
	for peg in $Pegs.get_children():
		var _ignore = peg.connect("destroyed", self, "_on_peg_destroyed")
	emit_signal("pegs_ready", _max_pegs)

func _on_peg_destroyed():
	emit_signal("peg_destroyed")
