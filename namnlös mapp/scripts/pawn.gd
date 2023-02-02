extends KinematicBody2D

var selected = false

"""
func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("curser") and get_parent().get_parent().whites_turn == true:
		selected = true
		print(selected)


func _on_Area2D_body_exited(body: Node) -> void:
	if body.is_in_group("curser") and get_parent().get_parent().whites_turn == true:
		selected = false
		print(selected)
"""
func selected() -> void:
	if selected == true:
		selected = false
		print(selected)
	else:
		selected = true
		print(selected)
