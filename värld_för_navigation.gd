extends Node2D
var cell_x = 0
var cell_y = 0
var compat_value = 0
var test = 0

onready var noise = OpenSimplexNoise.new()
onready var tile = get_node("Navigation2D/TileMap")
func _ready() -> void:
	randomize()
	noise.seed = randi()
	noise.period = 10
	noise.octaves = 1
	for i in 100:
		cell_x += 1
		cell_y = 0
		for j in 100:
			cell_y += 1
			
			var cell_xy = Vector2(cell_x, cell_y)
			
			test = int(round(noise.get_noise_2d(cell_x, cell_y)))
			if test < 0:
				compat_value = test * -1
			else:
				compat_value = test
			tile.set_cellv(cell_xy, compat_value)
			#tile.set_cellv(cell_xy, int(round(noise.get_noise_2d(cell_x, cell_y))))
			print(compat_value)
	
	
