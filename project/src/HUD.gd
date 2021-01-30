extends GridContainer

onready var _score_label := $ScoreLabel
onready var _lives_label := $BallsLabel
onready var _chain_label := $ChainLabel


func _ready():
	GameState.connect("score_changed", self, "_on_score_changed")
	GameState.connect("lives_changed", self, "_on_lives_changed")
	GameState.connect("chain_changed", self, "_on_chain_changed")
	_score_label.text = str(GameState.get_score())
	_lives_label.text = str(GameState.lives)
	_chain_label.text = str(GameState.get_chain())


func _on_score_changed(score:int)->void:
	_score_label.text = str(score)


func _on_lives_changed(lives:int)->void:
	_lives_label.text = str(lives)


func _on_chain_changed(chain:int)->void:
	_chain_label.text = str(chain)
