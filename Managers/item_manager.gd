extends Node
#Läser upp och hanterar json item filen
const ITEM_PATH = "res://items/data/items.json"

var items = {}

func _ready():
	var file = File.new()
	file.open(ITEM_PATH, File.READ)
	items = parse_json(file.get_as_text())
	file.close()

#plockar fram id från json
func get_item(id : String):
	return Item.new(id, items[id])


func get_items(items_data : Array):
	var items_array = []
	for item_data in items_data:
		items_array.append(get_item_from_data(item_data))
	return items_array


func get_item_from_data(item_data):
	var item = get_item(item_data.id)
	item.quantity = item_data.quantity
	return item
