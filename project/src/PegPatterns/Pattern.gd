extends Node2D

export var _rotating := false

func _ready():
	for child in get_children():
		if child is AnimationPlayer:
			child.play("Anim")
			var seek_to:int = randi()%int(child.current_animation_length)
			child.seek(seek_to, true)

func _process(delta):
	if _rotating:
		rotation_degrees += 0.25
