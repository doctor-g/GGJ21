extends GridContainer


func _ready():
	GameState.connect("score_changed", self, "_on_score_changed")
	GameState.connect("lives_changed", self, "_on_lives_changed")


func _on_score_changed(score:int)->void:
	$ScoreLabel.text = str(score)


func _on_lives_changed(lives:int)->void:
	$BallsLabel.text = str(lives)
