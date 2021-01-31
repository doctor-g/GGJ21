extends Node2D

export var _rotating := false
var rot_multiplier := 1

func _ready():
	var rotation_direction := randi()%2
	match rotation_direction:
		0:
			rot_multiplier = -1
		1:
			rot_multiplier = 1
	if _rotating:
		rotation_degrees = rand_range(1,360)
	for child in get_children():
		if child is AnimationPlayer:
			child.play("Anim")
			var seek_to:int = randi()%int(child.current_animation_length)
			child.seek(seek_to, true)

func _process(_delta):
	if _rotating:
		rotation_degrees += 0.25*rot_multiplier
