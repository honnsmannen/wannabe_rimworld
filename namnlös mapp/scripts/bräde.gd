extends TileMap

var x_pos = -32
var y_pos = -32

onready var detection_ruta = preload("res://scener/detection_ruta.tscn")

var detection_ruta_pos = Vector2(x_pos, y_pos)

func _ready() -> void:
	print($vit_pawn1.global_position)
	
	
	for x in 8:
		x_pos += 32
		y_pos = -32
		
		for y in 8:
			y_pos += 32
			detection_ruta_pos = Vector2(x_pos , y_pos)
			add_child(detection_ruta.instance())
