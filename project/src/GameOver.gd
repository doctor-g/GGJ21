extends Control

onready var _high_score := $Background/VBoxContainer/HighScore
onready var _score := $Background/VBoxContainer/YourScore
onready var _new_high := $Background/NewHigh
onready var _continue := $Background/VBoxContainer/ContinueButton

func _ready():
	_high_score.text = ""
	_score.text = ""
	_new_high.text = ""


func show():
	visible = true
	
	if GameState.highscore == GameState.get_score():
		_new_high.text = "New High Score! "+str(GameState.highscore)
	else:
		_high_score.text = "High Score: "+str(GameState.highscore)
		_score.text = "Your Score: "+str(GameState.get_score())
	
	if GameState.new_unlock:
		_continue.text = "Unlock Animal!"


func _on_PlayAgainButton_pressed():
	GameState.save_config() # This has to be done sometime, so do it now.
	if GameState.new_unlock:
		$Background.visible = false
		GameState.unlock_level += 1
		$Unlocked/NewAnimal.texture = AnimalSettings.ANIMALS[GameState.unlock_level].image
		$Unlocked.visible = true
		$Unlocked/AnimationPlayer.play("Wave")
	else:
		get_tree().change_scene("res://src/MainMenuScreen.tscn")


func _on_PostUnlockButton_pressed():
	get_tree().change_scene("res://src/MainMenuScreen.tscn")
