extends Control

export var icon_size := 100.0
export var sprite_offset := Vector2(10,5)

const BUTTON_FONT := preload("res://assets/fonts/qmark.tres")

var _music_bus_index := AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MuteMusicButton.pressed = AudioServer.is_bus_mute(_music_bus_index)
	
	for i in range(0,AnimalSettings.ANIMALS.size()):
		var button := Button.new()
		button.connect("pressed", self, "_on_Button_pressed", [i])
		button.size_flags_horizontal = SIZE_EXPAND_FILL
		button.size_flags_vertical = SIZE_EXPAND_FILL
		if i <= GameState.unlock_level:
			var sprite := Sprite.new()
			sprite.centered = false
			sprite.texture = AnimalSettings.ANIMALS[i].image
			var linear_scale := icon_size / sprite.texture.get_width()
			sprite.scale = Vector2(linear_scale, linear_scale)
			sprite.position = sprite_offset
			button.add_child(sprite)
		else:
			button.disabled = true
			button.text = "?"
			button.add_font_override("font", BUTTON_FONT)
		$AnimalGrid.add_child(button)
		

func _on_Button_pressed(animal_index)->void:
	GameState.reset()
	GameState.animal_index = animal_index
	get_tree().change_scene("res://src/Level.tscn")


func _on_MuteMusicButton_toggled(button_pressed):
	AudioServer.set_bus_mute(_music_bus_index, button_pressed)