extends RigidBody2D

var nav_obstacle = null
onready var tree_log = preload("res://scener/log.tscn")


func _ready():
	nav_obstacle = $Area2D/NavigationObstacle2D
	Navigation2DServer.agent_set_map(nav_obstacle.get_rid(), get_world_2d().get_navigation_map())
	Navigation2DServer.agent_set_radius(nav_obstacle.get_rid(), 10)
	$VisibilityNotifier2D.connect("screen_entered", self, "show")
	$VisibilityNotifier2D.connect("screen_exited", self, "hide")


func die() -> void:
	print("hallå?")
	add_child(tree_log.instance())
	queue_free()
	
	





func _on_Button_pressed() -> void:
	queue_free()
