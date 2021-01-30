extends Node2D

signal pegs_ready

const _peg := preload("res://src/Peg.tscn")

export var _max_pegs := 3.0
export var _min_distance_between_pegs := 40.0
export(float,0,1,0.1) var _percent_of_upgraded_pegs := 0.3

var _peg_positions := []
var _upgraded_pegs:int = 0

var _spawn_area_offset := Vector2.ZERO
var _spawn_area_bounds := Vector2.ZERO


func _ready():
	randomize()
# warning-ignore:narrowing_conversion
	_upgraded_pegs = ceil(_max_pegs*_percent_of_upgraded_pegs)
	var _spawn_area : Vector2 = $SpawnArea/CollisionShape2D.shape.extents*2
	_spawn_area_offset = (get_viewport_rect().size-_spawn_area)/2
	_spawn_area_bounds = _spawn_area
	_generate_pegs()


func _generate_pegs():
	for _i in _max_pegs:
		var found_position := false
		var pos:Vector2
		while not found_position:
			var pos_x := rand_range(_spawn_area_offset.x, _spawn_area_bounds.x)
			var pos_y := rand_range(_spawn_area_offset.y, _spawn_area_bounds.y)
			pos = Vector2(pos_x, pos_y)
			if not _is_within_min_distance_of_another_peg(pos):
				found_position = true
		
		_peg_positions.append(pos)
		
		var peg := _peg.instance()
		if _upgraded_pegs > 0:
			_upgraded_pegs -= 1
			peg.health = 3
		peg.position = pos
		$Pegs.add_child(peg)

	emit_signal("pegs_ready")


func _is_within_min_distance_of_another_peg(p:Vector2)->bool:
	for peg in _peg_positions:
		var distance_between_pegs := p.distance_to(peg)
		if distance_between_pegs < _min_distance_between_pegs:
			return true
	return false
