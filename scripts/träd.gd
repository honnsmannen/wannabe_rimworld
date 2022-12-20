extends Sprite





func _on_RigidBody2D_body_entered(body: Node) -> void:
	if body.is_in_group("filur"):
		print("hej")
		queue_free()
	
