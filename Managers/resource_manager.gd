class_name Resource_Manager extends Node
const RECIPE_PATH = "res://items/data/recipes.json"
#Mellanhand för sprites och recept m.m.


var recipes_info = {}

var sprites = {
	"wood": preload("res://items/sprites/wood.png"),
	"berry": preload("res://items/sprites/berries.png"),
	"stone": preload("res://items/sprites/stone.png"),
	"plank": preload("res://items/sprites/plank.png"),
	"bow": preload("res://items/sprites/bow.png"),
	"arrow": preload("res://items/sprites/arrow_bow.png"),
}

var fonts = {
	8: preload("res://font/font_8.tres")
}

var colors = {
	"normal": Color("905c32")
}

var tscn = {
	"floor_item": preload("res://items/floor_item.tscn"),
	"crafting_option": preload("res://ui/crafting_option.tscn"),
	"quantity": preload("res://items/quantity.tscn"),
	"item_quantity": preload("res://ui/item_quantity.tscn")
}
#Laddar recepten
func _ready():
	var file = File.new()
	

	file.open(RECIPE_PATH, File.READ)
	recipes_info = parse_json(file.get_as_text())
	file.close()


func get_instance(id):
	return tscn[id].instance()

func get_recipes(id):
	return recipes_info[id]
	

