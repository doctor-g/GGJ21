extends Control

var _pegs_remaining : int

onready var _shooter := $Shooter
onready var _offscreen := $OffScreen
onready var _EndGame := preload("res://src/EndGame.tscn")
onready var _target := $Target
onready var _target_animation_player := $TargetAnimationPlayer
onready var _game_over := $GameOver
onready var _level_clear := $LevelClear

export var _bin_scores := [30,20,10]

func _ready():
	_shooter.arm()


func _on_EndGame(bin):
	GameState.add_points(_bin_scores[abs(bin)])
	_level_clear.show()


func _on_OffScreen_body_entered(body):
	if body is Ball:
		body.queue_free()
		GameState.lives -= 1
		if GameState.lives > 0:
			_shooter.arm()
		else:
			_game_over.visible = true


func _on_PegGenerator_pegs_ready():
	_watch_pegs(self)


# Recursively descent through all nodes, attaching destruction
# listeners to each peg.
func _watch_pegs(node):
	for child in node.get_children():
		if child is Peg:
			_pegs_remaining += 1
			child.connect("destroyed", self, "_on_Peg_destroyed")
		else:
			_watch_pegs(child)


func _on_Peg_destroyed():
	_pegs_remaining -= 1
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


func _on_GameOver_dismissed():
	GameState.reset()
	get_tree().change_scene("res://src/Level.tscn")


func _on_LevelClear_dismissed():
	GameState.reset_chain()
	get_tree().change_scene("res://src/Level.tscn")
