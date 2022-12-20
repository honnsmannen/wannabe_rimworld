extends Node2D
var cell_x = 0
var cell_y = 0
var compenserat_value = 0
var test = 0
var tree_offset = Vector2(32,32)
var tree_pos := Vector2(0,0)
onready var tree = preload("res://scener/träd.tscn")
onready var noise = OpenSimplexNoise.new()
onready var tile = get_node("Navigation2D/TileMap")
func _ready() -> void:
	randomize()
	noise.seed = randi()
	noise.period = 15
	
	noise.octaves = 1
	for i in 500:
		cell_x += 1
		cell_y = 0
		for j in 500:
			cell_y += 1
			
			var cell_xy = Vector2(cell_x, cell_y)
			
			#fixar så att det inte finns -1 i värld genen
			if int(round(noise.get_noise_2d(cell_x, cell_y))) < 0:
				compenserat_value = int(round(noise.get_noise_2d(cell_x, cell_y))) * -1
			#ett lätt sätt att få ut slumpade platser på träd
			elif randi() % 37 == 1 and compenserat_value != 1:
				tree_pos = Vector2(cell_xy * 32 - tree_offset)
				print(tree_pos)
				var nytree = tree.instance()
				nytree.global_position = tree_pos
				add_child(nytree)
			else:
				compenserat_value = int(round(noise.get_noise_2d(cell_x, cell_y)))
			tile.set_cellv(cell_xy, compenserat_value)
			#print(tile.get)
			#tile.set_cellv(cell_xy, int(round(noise.get_noise_2d(cell_x, cell_y))))
			
	
	
