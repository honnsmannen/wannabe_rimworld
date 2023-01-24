extends Sprite

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("filurer"):
		body.item_picked_up("yxa")
