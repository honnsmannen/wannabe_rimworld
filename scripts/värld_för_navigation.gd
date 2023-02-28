extends Node2D


var cell_x = -1
var cell_y = -1
var compenserat_value = 0
var test = 0
var level_navigation_map
#var tree_offset = Vector2(32,32)
var tree_pos := Vector2(0,0)


var previous_left_mouse_click_global_position : Vector2
var previous_right_mouse_click_global_position : Vector2

onready var character = $KinematicBody2D
onready var parent_level_scene = ("res://scener/värld_för_navigation.tscn")

var characters = []


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
	
	for i in 50:
		cell_x += 1
		cell_y = 0
		for j in 50:
			cell_y += 1
			
			var cell_xy = Vector2(cell_x, cell_y)
			
			#fixar så att det inte finns -1 i värld genen
			if int(round(noise.get_noise_2d(cell_x, cell_y))) < 0:
				compenserat_value = int(round(noise.get_noise_2d(cell_x, cell_y))) * -1
			#ett lätt sätt att få ut slumpade platser på träd
			elif randi() % 14 == 1 and compenserat_value != 1:
				tree_pos = Vector2(cell_xy * 32)
				#print(tree_pos)
				var nytree = tree.instance()
				nytree.global_position = tree_pos
				add_child(nytree)
			else:
				compenserat_value = int(round(noise.get_noise_2d(cell_x, cell_y)))
			tile.set_cellv(cell_xy, compenserat_value)
			#print(tile.get)
			#tile.set_cellv(cell_xy, int(round(noise.get_noise_2d(cell_x, cell_y))))
			
	
func _process(delta: float) -> void:
	update()
	"""
	if Input.is_action_just_pressed("click"):
		
		var instanced_in_code := true
		var previous_left_mouse_click_global_position = get_global_mouse_position()
		#character.init_character(parent_level_scene, instanced_in_code)
		character.set_navigation_position(get_global_mouse_position())
	"""

		
		#print("shabatjena")
		
		#print("character.global_position: ", character.global_position)
		
		
		#print("get_global_mouse_position(): ",get_global_mouse_position())

		
		#print("character.set_navigation_position(get_global_mouse_position()): ", character.set_navigation_position(get_global_mouse_position()))
		
"""
func Hantera_left_click() -> void:
	
	previous_left_mouse_click_global_position = get_global_mouse_position()
	# set all level characters new navigation position
	for character in characters:
		character.set_navigation_position(get_global_mouse_position())
"""
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

"""
func _draw() -> void:
	# TODO: draw needs some clean up and has some draw errors
	# Error: canvas_item_add_polygon: Invalid polygon data, triangulation failed.
	for character in characters:
		if character is KinematicBody2D and is_instance_valid(character) and character.is_inside_tree():
			if character.character_nav_path.size() > 1:
				var previous_line_point : Vector2 = character.character_nav_path[1]
				for path_index in range(1, character.character_nav_path.size()):
					var line_point : Vector2 = character.character_nav_path[path_index]
					if previous_line_point is Vector2 and line_point is Vector2 and previous_line_point.distance_to(line_point) > 2.0:
						draw_line(previous_line_point, line_point, Color(1.0, 0.3, 0.7, 1.0), 3.0, false)
						draw_circle(line_point, 4.0, Color(0.1, 5.0, 0.6, 1.0))
					previous_line_point = line_point


			if character.character_real_nav_path.size() > 1:
				var previous_line_point : Vector2 = character.character_real_nav_path[0]
				for path_index in range(1, character.character_real_nav_path.size()):
					var line_point : Vector2 = character.character_real_nav_path[path_index]
					if previous_line_point is Vector2 and line_point is Vector2 and previous_line_point.distance_to(line_point) > 2.0:
						draw_line(previous_line_point, line_point, Color(0.6, 0.6, 0.2, 1.0), 3.0, false)
						draw_circle(line_point, 4.0, Color(0.3, 0.8, 0.2, 1.0))
					previous_line_point = line_point
			
			draw_circle(character.next_nav_position, 10.0, Color(0.5, 1.0, 0.1, 1.0))
			if character.global_position.distance_to(character.next_nav_position) > 1.0:
				draw_line(character.global_position, character.next_nav_position, Color(1.0, 0.6, 0.8, 1.0), 5.0, false)
			
			draw_circle(character.global_position, character.nav_agent.radius, Color(1.0, 0.0, 0.3, 1.0))
			
			draw_circle(character.nav_destination, character.nav_agent.radius, Color(0.7, 0.5, 0.2, 1.0))
			
			if character.global_position.distance_to(character.velocity) > 2.0:
				draw_line(character.global_position, character.global_position + character.velocity, Color(0.3, 0.5, 1.0, 1.0), 3.0, false)
			draw_circle(character.global_position + character.velocity, 5.0, Color(0.2, 0.5, 0.7, 1.0))
	"""
"""
	for obstacle in obstacles:
		if obstacle is Node2D and is_instance_valid(obstacle) and obstacle.is_inside_tree():
			if obstacle.nav_obstacle.estimate_radius:
				draw_circle(obstacle.global_position, obstacle.collision_radius, Color(0.5, 0.6, 0.4, 1.0))
			else:
				draw_circle(obstacle.global_position, obstacle.obstacle_nav_radius, Color(0.5, 0.6, 0.4, 1.0))
	
	if level_camera is Camera2D and is_instance_valid(level_camera) and level_camera.is_inside_tree():
		draw_line(level_camera.global_position, level_camera.camera_target_position, Color(0.3, 0.7, 0.1, 1.0), false)
	"""


func _on_TextureButton_pressed():
	pass # Replace with function body.
