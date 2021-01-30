extends Node2D

signal pegs_ready

const _Peg := preload("res://src/Peg.tscn")

export var max_patterns := 3
export var min_distance_between_patterns := 300
export var upgraded_pegs := 5
export var max_peg_health := 2

var _pattern_positions := []
var _peg_patterns  := [
	preload("res://src/PegPatterns/Circle.tscn"),
	preload("res://src/PegPatterns/Square.tscn"),
	preload("res://src/PegPatterns/RotatedSquare.tscn"),
	preload("res://src/PegPatterns/HollowSquare.tscn"),
	preload("res://src/PegPatterns/HollowCircle.tscn")
]
var _spawn_area_offset := Vector2.ZERO
var _spawn_area_bounds := Vector2.ZERO


func _ready():
	randomize()
# warning-ignore:narrowing_conversion
	var _spawn_area : Vector2 = $SpawnArea/CollisionShape2D.shape.extents*2
	_spawn_area_offset = (get_viewport_rect().size-_spawn_area)/2
	_spawn_area_bounds = _spawn_area+_spawn_area_offset
	print(_spawn_area_bounds)
	_generate_pegs()


func _generate_pegs():
	for _i in range(0,max_patterns):
		var found_position := false
		var pos:Vector2
		while not found_position:
			var pos_x := rand_range(_spawn_area_offset.x, _spawn_area_bounds.x)
			var pos_y := rand_range(_spawn_area_offset.y, _spawn_area_bounds.y)
			pos = Vector2(pos_x, pos_y)
			if not _is_within_min_distance_of_another_pattern(pos):
				found_position = true
		
		_pattern_positions.append(pos)
		
		var pattern_index = randi()%_peg_patterns.size()
		var Pattern = _peg_patterns[pattern_index]
		var pattern:Node2D = Pattern.instance()
		pattern.position = pos
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


func _is_within_min_distance_of_another_pattern(p:Vector2)->bool:
	for pattern in _pattern_positions:
		var distance_between_patterns := p.distance_to(pattern)
		if distance_between_patterns < min_distance_between_patterns:
			return true
	return false
