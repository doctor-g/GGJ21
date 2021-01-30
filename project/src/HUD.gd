extends GridContainer


func _ready():
	GameState.connect("score_changed", self, "_on_score_changed")
	GameState.connect("lives_changed", self, "_on_lives_changed")
	GameState.connect("chain_changed", self, "_on_chain_changed")


func _on_score_changed(score:int)->void:
	$ScoreLabel.text = str(score)


func _on_lives_changed(lives:int)->void:
	$BallsLabel.text = str(lives)


func _on_chain_changed(chain:int)->void:
	$ChainLabel.text = str(chain)
