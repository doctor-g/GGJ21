extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,GameState.unlock_level+1):
		var button := Button.new()
		button.icon = AnimalSettings.ANIMALS[i].image
		button.connect("pressed", self, "_on_Button_pressed", [i])
		$AnimalGrid.add_child(button)


func _on_Button_pressed(animal_index)->void:
	GameState.reset()
	GameState.animal_index = animal_index
	get_tree().change_scene("res://src/Level.tscn")
