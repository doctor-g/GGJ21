extends Node2D

enum _State {IDLE, READY, LOADED, AIMING}

const _Ball := preload("res://src/Ball.tscn")

export var _initial_impulse := 400
export var _one_shot := false

var _state = _State.IDLE
var _ball : RigidBody2D
var _mouse_pos : Vector2


# Call to prepare this thing for launch
func arm():
	_state = _State.READY


func _input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and _state == _State.READY:
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
		$Sprite.show()
		_mouse_pos = get_viewport().get_mouse_position()
		rotation = (get_global_transform().origin-_mouse_pos).angle()
	else:
		$Sprite.hide()


func _shoot_ball():
	GameState.lives -= 1
	$Shot.play()
	GameState.reset_chain()
	_ball.mode = RigidBody2D.MODE_RIGID
	var angle = (_mouse_pos - get_global_transform().get_origin()).angle()
	var impulse_vector := Vector2(_initial_impulse, 0).rotated(angle)
	_ball.apply_impulse(Vector2.ZERO, impulse_vector)
	_state = _State.IDLE
