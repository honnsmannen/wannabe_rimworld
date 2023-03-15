extends RigidBody2D

var nav_obstacle = null

func _ready():
	nav_obstacle = $Area2D/NavigationObstacle2D
	Navigation2DServer.agent_set_map(nav_obstacle.get_rid(), get_world_2d().get_navigation_map())
	Navigation2DServer.agent_set_radius(nav_obstacle.get_rid(), 10)


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.active_item == "yxa":
		print("hej")
		queue_free()
	





func _on_Button_pressed() -> void:
	queue_free()
