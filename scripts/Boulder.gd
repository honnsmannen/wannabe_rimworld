extends RigidBody2D
var nav_obstacle = null
onready var floor_item = preload("res://items/floor_item.tscn")
#onready var tree = preload("res://items/data/tree.tscn")
var item : Item = null




func _ready():
	#SignalManager.connect( "item_dropped", self, "_on_item_dropped" )
	nav_obstacle = $Area2D/NavigationObstacle2D
	Navigation2DServer.agent_set_map(nav_obstacle.get_rid(), get_world_2d().get_navigation_map())
	Navigation2DServer.agent_set_radius(nav_obstacle.get_rid(), 10)
	#$VisibilityNotifier2D.connect("screen_entered", self, "show")
	#$VisibilityNotifier2D.connect("screen_exited", self, "hide")

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		var boulder_pos = position
		print(boulder_pos)
		create_stone_item(boulder_pos)
		queue_free()

func create_stone_item(pos):
	var floor_item_scene = load("res://items/floor_item.tscn")
	var stone_item = floor_item_scene.instance()
	
	stone_item.item_id = "stone"
	get_parent().call_deferred("add_child", stone_item)
	stone_item.position = pos

