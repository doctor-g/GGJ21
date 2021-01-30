extends Node2D

# Emitted when the ball falls into a bin.
# The bin will be an integer in the range [-2,2], with zero being the center bin.
signal endgame(bin)

func _ready():
	var bin_number := -2
	for child in get_children():
		if child is Area2D:
			child.connect("body_entered", self, "_on_Area2D_entered", [bin_number])
			bin_number += 1


func _on_Area2D_entered(body, bin):
	if body is Ball:
		emit_signal("endgame", bin)
		body.queue_free()
