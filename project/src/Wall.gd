extends StaticBody2D

export (float, 0, 1, 0.1) var bounciness := 1.0


func _ready():
	Physics2DServer.body_set_param(get_rid(), Physics2DServer.BODY_PARAM_BOUNCE, bounciness)
