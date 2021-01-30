class_name Ball 
extends RigidBody2D

func _ready():
	$Sprite.texture = AnimalSettings.ANIMALS[GameState.animal_index].image


func _on_Ball_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	if body is Peg:
		$PegHit.play()
		body.hit()
	else:
		$TrampolineHit.play()
