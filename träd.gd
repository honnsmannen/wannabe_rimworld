extends RigidBody2D






func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("filur"):
		print("hej")
		queue_free()
	
