class_name Peg
extends StaticBody2D

const _hit_particles := preload("res://src/HitParticles.tscn")

signal destroyed()

export var points_for_hit := 10
export var points_for_destroy := 50
export var health := 1 setget _set_health
export var _gradient:Gradient

onready var _colored_part := $PegBackground
onready var _tween := $Tween

var _health_colors := [Color.blue, Color.red, Color(0.2,0.2,0.2)]


func _ready():
	_update_color()
	

func _update_color():
	_colored_part.modulate = _health_colors[health-1]


func _set_health(value):
	health = value
	_update_color()


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
		$CollisionShape2D.set_deferred("disabled", true)
		GameState.increase_chain()
		GameState.add_points(points_for_destroy)
		
		_tween.interpolate_property(_colored_part, "modulate", null, Color.white, 0.05)
		_tween.start()
		_tween.connect("tween_all_completed", self, "_on_modulate_complete")




func _on_modulate_complete():
	emit_signal("destroyed")
	_gradient.colors[1] = Color.blue
	_spawn_particles(_hit_particles)
	queue_free()


func _spawn_particles(particles:PackedScene):
	var _Particles := particles.instance()
	_Particles.position = get_global_transform().origin
	_Particles.color_ramp = _gradient
	get_tree().root.add_child(_Particles)
