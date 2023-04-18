extends Sprite


var player = null
var being_picked_up = false


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.item_picked_up("yxa", 1)
		queue_free()
