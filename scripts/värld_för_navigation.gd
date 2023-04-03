extends Node2D


var cell_x = -1
var cell_y = -1
var compenserat_value = 0
var test = 0
var level_navigation_map
#var tree_offset = Vector2(32,32)
var tree_pos := Vector2(0,0)
var bush_pos := Vector2(0,0)
var stone_pos := Vector2(0,0)

var not_tree_list = []
var not_bush_list = []
var tree_list = []
var bush_list = []
var stone_list = []

var generating = true
var current_tiles = []
var not_cleared = false

var previous_left_mouse_click_global_position : Vector2
var previous_right_mouse_click_global_position : Vector2

#onready var character = $KinematicBody2D
onready var parent_level_scene = ("res://scener/värld_för_navigation.tscn")
onready var filuren = $Filuren

onready var game_over = preload("res://scener/Game_Over.tscn")

var characters = []

onready var bush = preload("res://scener/Bush.tscn")
onready var tree = preload("res://scener/träd.tscn")
onready var stone = preload("res://scener/Boulder.tscn")
onready var noise = OpenSimplexNoise.new()
onready var tree_noise = OpenSimplexNoise.new()
onready var bush_noise = OpenSimplexNoise.new()
onready var stone_noise = OpenSimplexNoise.new()
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
	
	noise.octaves = 2
	
	tree_noise.seed = randi() * 2
	bush_noise.seed = randi() * 2
	stone_noise.seed = randi() * 2
	
	tree_noise.period = 1
	bush_noise.period = 1
	stone_noise.period = 1

	tree_noise.octaves = 1
	bush_noise.octaves = 1
	stone_noise.octaves = 1
	
	


func _process(delta: float) -> void:
	update()
	world_gen(40, 20)
	_world_destruction(45,25)
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
				generating = false
			
			# Generate world data at (x, y)
			else:
				var noise_x = x
				var noise_y = y
				var noise_value = noise.get_noise_2d(noise_x, noise_y)
				
				var tree_noise_value = abs(tree_noise.get_noise_2d(noise_x, noise_y))
				var bush_noise_value = abs(bush_noise.get_noise_2d(noise_x, noise_y))
				var stone_noise_value = abs(stone_noise.get_noise_2d(noise_x, noise_y))
				compenserat_value = round(abs(noise_value))
				
				
				if tree_noise_value > 0.75 and not Vector2(x,y) in tree_list:
					tree_pos = Vector2(x * 32, y * 32)
					tree_list.append(Vector2(x,y))
					var nytree = tree.instance()
					nytree.global_position = tree_pos
					add_child(nytree)
				if bush_noise_value > 0.85 and not Vector2(x,y) in bush_list:
					bush_pos = Vector2(x * 32, y * 32)
					bush_list.append(Vector2(x,y))
					var nybush = bush.instance()
					nybush.global_position = bush_pos
					add_child(nybush)
				if stone_noise_value > 0.85 and not Vector2(x,y) in stone_list:
					stone_pos = Vector2(x * 32, y * 32)
					stone_list.append(Vector2(x,y))
					var nystone = stone.instance()
					nystone.global_position = stone_pos
					add_child(nystone)
				

					
				
				$TileMap.set_cell(x, y, int(compenserat_value))
				current_tiles.append(Vector2(x,y))
				if current_tiles.size() > width * height:
					current_tiles.remove(0)
				#fixa så att den tar bort den tile som är längst bort från splearen
					
					#_distance_from_2020(current_tiles, width, height)
					
				#print("generating")
				generating = true
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
				not_cleared = true
"""
func _distance_from_2020(input_array : Array,x : int, y : int) -> void:
	var array_to_compare = input_array 
	if !generating and not_cleared:
		for i in range(x*y,0,-1):
			
			var compared_array = Vector2(x/2,y/2) - array_to_compare[i]
			if compared_array.x > 15 or compared_array.x < -15 or compared_array.y > 15 or compared_array.y < -15:
				current_tiles.erase(array_to_compare[i-1])
		not_cleared = false
"""


func _on_Filuren_died() -> void:
	add_child(game_over.instance())
