extends KinematicBody2D


func _draw():
	var radius = $CollisionShape2D.shape.radius
	var height = $CollisionShape2D.shape.height
	var color = Color.aliceblue
	draw_circle(Vector2(height/2,0), radius, color)
	draw_circle(-Vector2(height/2,0), radius, color)
	draw_rect(Rect2(-Vector2(height, radius*2)/2, Vector2(height, radius*2)), color)
