extends Control

signal dismissed

var _score := 0

func _process(_delta):
	GameState.connect("score_changed", self, "score_changed")
	if GameState.highscore == _score:
		$Label2.text = "New High Score! "+str(GameState.highscore)
	else:
		$Label2.text = "High Score: "+str(GameState.highscore)+", Your Score: "+str(_score)


func score_changed(score:int):
	if score != null:
		_score = score


func _on_PlayAgainButton_pressed():
	emit_signal("dismissed")
