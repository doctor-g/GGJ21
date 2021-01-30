extends Node2D

const _ScoreBonusPopup := preload("res://src/ScoreBonusPopup.tscn")

export var _bin_scores := [500,200,100]

# Emitted when the ball falls into a bin.
# The bin will be an integer in the range [-2,2], with zero being the center bin.
signal endgame(bin)

func _ready():
	var bin_number := -2
	for child in get_children():
		if child is Area2D:
			child.connect("body_entered", self, "_on_Area2D_entered", [child, bin_number])
			bin_number += 1


func _on_Area2D_entered(body, area, bin):
	if body is Ball:
		var bonus_points := _get_bin_value(bin)
		GameState.add_points(bonus_points)
		var popup := _ScoreBonusPopup.instance()
		popup.text = "+%d" % bonus_points
		popup.rect_position = Vector2(50, -100) # These magic numbers happened to work.
		area.add_child(popup)
		emit_signal("endgame", bin)
		body.queue_free()


func _get_bin_value(bin)->int:
	return _bin_scores[abs(bin)]
