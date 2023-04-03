extends RigidBody2D


var full = preload("res://sprites/berry_full_bush.png")
var less = preload("res://sprites/berryless_bush.png")
onready var floor_item = preload("res://items/floor_item.tscn")
var item : Item = null

signal bush_sprite_changed

enum {BERRY_FULL, BERRY_LESS}
var nav_obstacle = null

var state = BERRY_FULL
var has_entered_less_state = false 

func _ready():
	nav_obstacle = $Area2D/NavigationObstacle2D
	Navigation2DServer.agent_set_map(nav_obstacle.get_rid(), get_world_2d().get_navigation_map())
	Navigation2DServer.agent_set_radius(nav_obstacle.get_rid(), 10)

func _process(delta: float):
	match state:
		BERRY_FULL:
			_berry_full_state()

		BERRY_LESS:
			print("unfull")
			if not has_entered_less_state: 
				_berry_less_state()
				has_entered_less_state = true
				print("berry less")


func _on_Area2D_body_entered(body: Node) -> void: #Plockar bär vid kollision med spelaren 
	if body.is_in_group("player") and state == BERRY_FULL:#Men enbart om busken har bär
		var tree_pos = position
		state = BERRY_LESS
		create_berry_item(tree_pos + Vector2(0, 70))


func create_berry_item(pos):
	var floor_item_scene = load("res://items/floor_item.tscn")
	var berry_item = floor_item_scene.instance()
	
	berry_item.item_id = "berry"
	get_parent().add_child(berry_item)
	berry_item.position = pos


func _berry_full_state():
	SignalManager.emit_signal("bush_sprite_changed", full)


func _berry_less_state():
	$grow_timer.start()
	SignalManager.emit_signal("bush_sprite_changed", less)


func _on_grow_timer_timeout() -> void:
	state = BERRY_FULL
	has_entered_less_state = false
