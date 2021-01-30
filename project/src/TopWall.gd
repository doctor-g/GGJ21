extends StaticBody2D


# When the ball exits the area, turn on collisions on the top wall.
func _on_Area2D_body_exited(body):
	if body is Ball:
		call_deferred("_enable_collision")


func _enable_collision():
	$CollisionShape2D.disabled = false
	

func reset():
	call_deferred("_disable_collision")
	

func _disable_collision():
	$CollisionShape2D.disabled = true
	
