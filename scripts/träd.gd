extends RigidBody2D



var nav_obstacle = null
onready var floor_item = preload("res://items/floor_item.tscn")
var item : Item = null


func _ready():

	nav_obstacle = $Area2D/NavigationObstacle2D
	Navigation2DServer.agent_set_map(nav_obstacle.get_rid(), get_world_2d().get_navigation_map())
	Navigation2DServer.agent_set_radius(nav_obstacle.get_rid(), 10)
	$VisibilityNotifier2D.connect("screen_entered", self, "show")
	$VisibilityNotifier2D.connect("screen_exited", self, "hide")


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("yxa"):
		var tree_pos = position
		print(tree_pos)
		create_wood_item(tree_pos)
		queue_free()

func create_wood_item(pos):
	var floor_item_scene = load("res://items/floor_item.tscn")
	var wood_item = floor_item_scene.instance()
	
	wood_item.item_id = "wood"
	get_parent().call_deferred("add_child", wood_item)
	#get_parent().add_child(wood_item)
	wood_item.position = pos



func _on_Area2D_area_entered(area: Area2D) -> void:
		if area.is_in_group("yxa"):
			var tree_pos = position
			print(tree_pos)
			create_wood_item(tree_pos)
			queue_free()
