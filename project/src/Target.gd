extends KinematicBody2D

export (float, 0, 1, 0.1) var bounciness := 1.0

func _ready():
	# See https://godotengine.org/qa/79826/adjusting-the-physical-material-of-kinematicbody
	# This allows us to change the physics properties of a kinematic body. Cool.
	Physics2DServer.body_set_param(get_rid(), Physics2DServer.BODY_PARAM_BOUNCE, bounciness)
	
