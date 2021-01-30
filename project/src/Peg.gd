class_name Peg
extends StaticBody2D

const _destroyed_particles := preload("res://src/DestroyedParticles.tscn")
const _hit_particles := preload("res://src/HitParticles.tscn")

signal destroyed()

export var points_for_hit := 10
export var points_for_destroy := 50
export var health := 1
export var _gradient:Gradient

onready var _colored_part := $PegBackground
onready var _tween := $Tween

var _health_colors := [Color.blue, Color.orange, Color.red]


func _ready():
	_colored_part.modulate = _health_colors[health-1]


func hit():
	health -= 1
	if health > 0:
		GameState.add_points(points_for_hit)
		
		var next_color:Color = _health_colors[health-1]
		_gradient.colors[1] = _health_colors[health]
		_spawn_particles(_hit_particles)
		_tween.interpolate_property(_colored_part, "modulate", null, Color.white, 0.05)
		_tween.start()
		yield(get_tree().create_timer(0.05), "timeout")
		_tween.interpolate_property(_colored_part, "modulate", null, next_color, 0.05)
		_tween.start()
		
	if health <= 0:
		GameState.increase_chain()
		GameState.add_points(points_for_destroy)
		
		_tween.interpolate_property(_colored_part, "modulate", null, Color.white, 0.05)
		_tween.start()
		yield(get_tree().create_timer(0.05), "timeout")
		emit_signal("destroyed")
		_spawn_particles(_destroyed_particles)
		queue_free()


func _spawn_particles(particles:PackedScene):
	var _Particles := particles.instance()
	_Particles.position = get_global_transform().origin
	if health > 0:
		_Particles.color_ramp = _gradient
	get_tree().root.add_child(_Particles)
