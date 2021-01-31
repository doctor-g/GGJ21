extends Control

onready var _score_label := $ScoreBox/ScoreLabel
onready var _lives_label := $LivesBox/LivesLabel
onready var _chain_label := $ChainLabel

export var lerp_percent_per_frame := 0.3

var _target_score := 0
var _displayed_score := 0

func _ready():
	GameState.connect("score_changed", self, "_on_score_changed")
	GameState.connect("lives_changed", self, "_on_lives_changed")
	GameState.connect("chain_changed", self, "_on_chain_changed")
	_score_label.text = str(GameState.get_score())
	_lives_label.text = str(GameState.lives)
	_chain_label.text = str(GameState.get_chain())


func _physics_process(_delta):
	_displayed_score = lerp(_displayed_score, _target_score, lerp_percent_per_frame)
	_score_label.text = str(_displayed_score)


func _on_score_changed(score:int)->void:
	_target_score = score


func _on_lives_changed(lives:int)->void:
	_lives_label.text = str(lives)


func _on_chain_changed(chain:int)->void:
	_chain_label.text = str(chain)
