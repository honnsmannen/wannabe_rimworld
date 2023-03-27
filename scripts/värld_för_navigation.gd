extends Node2D


var cell_x = -1
var cell_y = -1
var compenserat_value = 0
var test = 0
var level_navigation_map
#var tree_offset = Vector2(32,32)
var tree_pos := Vector2(0,0)
var bush_pos := Vector2(0,0)
var not_tree_list = []
var tree_list = []

var generating = true
var current_tiles = []

var previous_left_mouse_click_global_position : Vector2
var previous_right_mouse_click_global_position : Vector2

onready var character = $KinematicBody2D
onready var parent_level_scene = ("res://scener/värld_för_navigation.tscn")
onready var filuren = $Filuren

var characters = []

onready var Bush = preload("res://scener/Bush.tscn")
onready var tree = preload("res://scener/träd.tscn")
onready var noise = OpenSimplexNoise.new()
onready var tile = get_node("TileMap")
func _ready() -> void:
	level_navigation_map = get_world_2d().get_navigation_map()
	init_pre_existing_level_characters()
	
	
	"""
	de här är till för generationen av världen.
	"""
	randomize()
	noise.seed = randi()
	noise.period = 15
	
	noise.octaves = 1
	
func _process(delta: float) -> void:
	update()
	world_gen(40, 40)
	_world_destruction(60,60)
func init_pre_existing_level_characters() -> void:
	# init all the character scenes in the scene tree when starting the level
	# other characters created in create_character() will be initilized at that time
	for child_node in get_children():
		if child_node is KinematicBody2D:
			if child_node.has_method("init_character"):
				if characters.empty():
					# if no target i.e. left mouse click yet, set target to character position
					previous_left_mouse_click_global_position = child_node.global_position
				child_node.init_character(self, false)
				characters.push_back(child_node)

func world_gen(width: int, height: int) -> void:
	
	var center = filuren.global_position
	var start_x = int(center.x / 32) - width/2
	var start_y = int(center.y / 32) - height/2
	for x in range(start_x, start_x + width):
		for y in range(start_y, start_y + height):
			if Vector2(x,y) in current_tiles:
				pass	
			
			# Generate world data at (x, y)
			else:
				var noise_x = x
				var noise_y = y
				var noise_value = noise.get_noise_2d(noise_x, noise_y)
					
				"""
				den kommande biten skrev jag
				"""
				if noise_value < 0:
					compenserat_value = int(round(noise_value)) * -1
				else:
					compenserat_value = int(round(noise_value))
					
				if not randi() % 14 == 1 and compenserat_value != 1:
					if not Vector2(x,y) in not_tree_list:
						not_tree_list.append(Vector2(x,y))
					
				elif randi() % 14 == 1 and compenserat_value != 1:
					if not Vector2(x,y) in tree_list and not Vector2(x,y) in not_tree_list:
						tree_pos = Vector2(x * 32, y * 32)
						tree_list.append(Vector2(x,y))
						#print(tree_list)
						var nytree = tree.instance()
						nytree.global_position = tree_pos
						add_child(nytree)
					
					
				
				$TileMap.set_cell(x, y, int(compenserat_value))
				current_tiles.append(Vector2(x,y))
				if current_tiles.size() > width * height:
					current_tiles.remove(0)
				#fixa så att den tar bort den tile som är längst bort från splearen

func _world_destruction(width , height) -> void:
	var center = filuren.global_position
	var start_x = int(center.x / 32) - width/2
	var start_y = int(center.y / 32) - height/2
	for x in range(start_x, start_x + width):
		for y in range(start_y, start_y + height):
			if Vector2(x,y) in current_tiles:
				pass
			else:	
				$TileMap.set_cell(x, y, -1)
		
