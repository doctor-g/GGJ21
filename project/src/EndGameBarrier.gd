extends StaticBody2D

export var color := Color.aliceblue

func _draw():
	var shape = $CollisionShape2D.shape
	var radius = shape.radius
	var height = shape.height
	draw_circle(Vector2(0,height/2), radius, color)
	draw_circle(-Vector2(0,height/2), radius, color)
	draw_rect(Rect2(-Vector2(radius*2,height)/2, Vector2(radius*2,height)), color)
