extends Control


onready var _shooter := $Shooter

# Called when the node enters the scene tree for the first time.
func _ready():
	_shooter.arm()


func _on_OffScreen_body_entered(body):
	if body is Ball:
		body.queue_free()
		_shooter.arm()
