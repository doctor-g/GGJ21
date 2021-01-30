extends Control

var _pegs_remaining : int

onready var _shooter := $Shooter
onready var _pegs := $Pegs

func _ready():
	_shooter.arm()
	for peg in _pegs.get_children():
		_pegs_remaining += 1
		peg.connect("destroyed", self, "_on_Peg_destroyed", [], CONNECT_ONESHOT)


func _on_Peg_destroyed():
	_pegs_remaining -= 1
	if _pegs_remaining <= 0:
		print("Level clear")


func _on_OffScreen_body_entered(body):
	if body is Ball:
		body.queue_free()
		_shooter.arm()
