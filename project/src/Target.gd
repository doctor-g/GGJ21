extends KinematicBody2D

export (float, 0, 1, 0.1) var bounciness := 1.0

func _ready():
	# See https://godotengine.org/qa/79826/adjusting-the-physical-material-of-kinematicbody
	# This allows us to change the physics properties of a kinematic body. Cool.
	Physics2DServer.body_set_param(get_rid(), Physics2DServer.BODY_PARAM_BOUNCE, bounciness)
	

func _draw():
	var radius = $CollisionShape2D.shape.radius
	var height = $CollisionShape2D.shape.height
	var color = Color.aliceblue
	draw_circle(Vector2(height/2,0), radius, color)
	draw_circle(-Vector2(height/2,0), radius, color)
	draw_rect(Rect2(-Vector2(height, radius*2)/2, Vector2(height, radius*2)), color)
