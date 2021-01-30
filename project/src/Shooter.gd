extends Node2D

enum _State {IDLE, LOADED, AIMING}

const _ball := preload("res://src/Ball.tscn")

export var _initial_impulse := 400
export var _one_shot := false

var _state = _State.AIMING

func _input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and _state == _State.AIMING:
			_state = _State.LOADED
		elif not event.pressed and _state == _State.LOADED:
			if _one_shot:
				_state = _State.IDLE
			else:
				_state = _State.AIMING
			_shoot_ball()

func _process(_delta):
	if _state != _State.IDLE:
		var mouse_pos = get_global_mouse_position()
		rotation = mouse_pos.angle()

func _shoot_ball():
	var _Ball:RigidBody2D = _ball.instance()
	_Ball.position = get_global_transform().origin
	get_tree().root.add_child(_Ball)
	_Ball.apply_impulse(Vector2.ZERO, Vector2(_initial_impulse, 0).rotated(rotation))
