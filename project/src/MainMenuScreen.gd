extends Control

export var _pressed:StyleBoxFlat = StyleBoxFlat.new()
export var _hover:StyleBoxFlat = StyleBoxFlat.new()
export var _normal:StyleBoxFlat = StyleBoxFlat.new()
export var _disabled:StyleBoxFlat = StyleBoxFlat.new()
export var icon_size := 100.0
export var sprite_offset := Vector2(10,5)
export var _button_font_color := Color("#f2d972")

const BUTTON_FONT := preload("res://assets/fonts/qmark.tres")
const UNLOCK_FONT := preload("res://assets/fonts/unlock_memo.tres")
const _ConfirmationDialog := preload("res://src/ConfirmationDialog.tscn")

var _music_bus_index := AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MuteMusicButton.pressed = AudioServer.is_bus_mute(_music_bus_index)
	$FullscreenButton.pressed = OS.window_fullscreen
	
	for i in range(0,AnimalSettings.ANIMALS.size()):
		var button := Button.new()
		button.set("custom_styles/hover", _hover)
		button.set("custom_styles/pressed", _pressed)
		button.set("custom_styles/normal", _normal)
		button.set("custom_styles/disabled", _disabled)
		button.connect("pressed", self, "_on_Button_pressed", [i])
		button.size_flags_horizontal = SIZE_EXPAND_FILL
		button.size_flags_vertical = SIZE_EXPAND_FILL
		if i <= GameState.unlock_level:
			var sprite := Sprite.new()
			sprite.centered = false
			sprite.texture = AnimalSettings.ANIMALS[i].image
			var linear_scale := icon_size / max(sprite.texture.get_width(), sprite.texture.get_height())
			sprite.scale = Vector2(linear_scale, linear_scale)
			sprite.position = sprite_offset
			button.add_child(sprite)
		else:
			button.disabled = true
			button.text = "?"
			button.set("custom_colors/font_color_disabled", _button_font_color)
			button.add_font_override("font", BUTTON_FONT)
			if GameState.unlock_level + 1 == i:
				var label := Label.new()
				label.align = HALIGN_CENTER
				label.text = '%d to unlock!' % AnimalSettings.ANIMALS[i].score
				label.set("custom_colors/font_color", _button_font_color)
				label.rect_position = Vector2(18,80) # It works, the magic number.
				label.add_font_override("font", UNLOCK_FONT)
				button.add_child(label)
		$AnimalGrid.add_child(button)
		

func _on_Button_pressed(animal_index)->void:
	$ButtonClicked.play()
	yield(get_tree().create_timer(0.08), "timeout")
	GameState.reset()
	GameState.animal_index = animal_index
	get_tree().change_scene("res://src/Level.tscn")


func _on_MuteMusicButton_toggled(button_pressed):
	AudioServer.set_bus_mute(_music_bus_index, button_pressed)


func _on_FullscreenButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_ResetButton_pressed():
	var dialog := _ConfirmationDialog.instance()
	dialog.connect("confirmed", self, "_on_ConfirmationDialog_confirmed")
	add_child(dialog)


func _on_ConfirmationDialog_confirmed():
	GameState.reset_config()
	get_tree().change_scene("res://src/MainMenuScreen.tscn")
