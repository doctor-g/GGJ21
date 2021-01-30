extends Control

func _ready():
	$Background/HighScore.text = ""
	$Background/YourScore.text = ""
	$Background/NewHigh.text = ""


func show():
	visible = true
	
	if GameState.highscore == GameState.get_score():
		$Background/NewHigh.text = "New High Score! "+str(GameState.highscore)
	else:
		$Background/HighScore.text = "High Score: "+str(GameState.highscore)
		$Background/YourScore.text = "Your Score: "+str(GameState.get_score())
	
	if GameState.new_unlock:
		$Background/PopupButton.text = "Unlock Animal!"


func _on_PlayAgainButton_pressed():
	if GameState.new_unlock:
		$Background.visible = false
		GameState.unlock_level += 1
		$NewAnimal.texture = AnimalSettings.ANIMALS[GameState.unlock_level].image
		$NewAnimal.visible = true
	else:
		get_tree().change_scene("res://src/MainMenuScreen.tscn")


func _on_PostUnlockButton_pressed():
	get_tree().change_scene("res://src/MainMenuScreen.tscn")
