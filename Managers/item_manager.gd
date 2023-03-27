extends Node
#Läser upp och hanterar json item filen
const ITEM_PATH = "res://items/data/items.json"

var items = {}

func _ready():
	var file = File.new()
	file.open( ITEM_PATH, File.READ )
	items = parse_json( file.get_as_text() )
	file.close()

func get_item(id : String):
	return Item.new(id, items[id])
