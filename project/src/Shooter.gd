extends Node2D

enum _State {IDLE, LOADED, AIMING}

const _Ball := preload("res://src/Ball.tscn")

export var _initial_impulse := 400
export var _one_shot := false

var _state = _State.IDLE
var _ball : RigidBody2D
var _mouse_pos : Vector2


func _input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and _state == _State.IDLE:
			_load_ball()
		elif not event.pressed and _state == _State.AIMING:
			_shoot_ball()


func _load_ball():
	_state = _State.AIMING
	_ball = _Ball.instance()
	_ball.mode = RigidBody2D.MODE_STATIC
	_ball.position = get_global_transform().origin
	get_parent().add_child(_ball)


func _process(_delta):
	if _state == _State.AIMING:
		_mouse_pos = get_viewport().get_mouse_position()
		update()

func _draw():
	if _state == _State.AIMING:
		draw_line(Vector2.ZERO, _mouse_pos - get_global_transform().get_origin(), Color.black, 5)
		
	
func _shoot_ball():
	update() # Force redraw to eliminate drawn line
	_ball.mode = RigidBody2D.MODE_RIGID
	var angle = (_mouse_pos - get_global_transform().get_origin()).angle()
	var impulse_vector := Vector2(_initial_impulse, 0).rotated(angle)
	_ball.apply_impulse(Vector2.ZERO, impulse_vector)
	_state = _State.IDLE
