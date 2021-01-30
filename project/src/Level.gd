extends Control

var _pegs_remaining : int

onready var _shooter := $Shooter
onready var _offscreen := $OffScreen
onready var _EndGame := preload("res://src/EndGame.tscn")
onready var _target := $Target
onready var _target_animation_player := $TargetAnimationPlayer

func _ready():
	_shooter.arm()
	


func _on_Peg_destroyed():
	_pegs_remaining -= 1
	GameState.score += 10
	if _pegs_remaining <= 0:
		# This is a lot of manual fiddling to transition from the regular
		# play state into the one where you hope the ball falls into the 
		# best bin.
		_target_animation_player.stop()
		_target.queue_free()
		_offscreen.queue_free()
		var endgame : Node2D = _EndGame.instance()
		endgame.position = Vector2(0,800)
		call_deferred("add_child", endgame)
		endgame.connect("endgame", self, "_on_EndGame", [], CONNECT_ONESHOT)


func _on_EndGame(bin):
	print('Completed the level in bin %d' % bin)


func _on_OffScreen_body_entered(body):
	if body is Ball:
		body.queue_free()
		GameState.lives -= 1
		if GameState.lives > 0:
			_shooter.arm()
		else:
			print("TODO: Handle Game Over")


func _on_PegGenerator_pegs_ready(pegs):
	_pegs_remaining = pegs
