extends Control

signal dismissed

var _score := 0

func _ready():
	$HighScore.text = ""
	$YourScore.text = ""
	$NewHigh.text = ""
	GameState.connect("score_changed", self, "score_changed")

func _process(_delta):
	if visible:
		if GameState.highscore == _score:
			$NewHigh.text = "New High Score! "+str(GameState.highscore)
		else:
			$HighScore.text = "High Score: "+str(GameState.highscore)
			$YourScore.text = "Your Score: "+str(_score)


func score_changed(score:int):
	if score != null:
		_score = score


func _on_PlayAgainButton_pressed():
	emit_signal("dismissed")
