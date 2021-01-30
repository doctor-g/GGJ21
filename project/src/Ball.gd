class_name Ball 
extends RigidBody2D

var alpha

func _process(delta):
	alpha = lerp(0,1,clamp(linear_velocity.length_squared()/300000, 0, 1))
	$CPUParticles2D.modulate = Color(1,1,1,alpha)

func _on_Ball_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	if body is Peg:
		$PegHit.play()
		body.hit()
	else:
		$TrampolineHit.play()
