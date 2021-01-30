extends RigidBody2D



func _on_Ball_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	if body is Peg:
		body.hit()
