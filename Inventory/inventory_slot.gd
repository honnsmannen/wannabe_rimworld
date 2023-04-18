#class_name Inventory_Slot buggar ibland, bara starta spelet igen
class_name Inventory_Slot

extends TextureRect

signal item_changed()

export(NodePath) onready var item_container = get_node(item_container) as Control

var key
var item: Item
var ready = false
var groups : Array = []

func _ready():
	ready = true
	
	if item:
		item_container.add_child(item)
		
func get_input():
	if Input.is_action_just_released("eat"):
		eat(item)


func _process(delta) -> void:
	get_input()

func set_item(new_item): #Gör item möjlig att läggas till
	if not new_item:
		item_container.remove_child(item)
	elif ready:
		item_container.add_child(new_item)
	item = new_item


func eat(item): #funktion för att käka
	if item:
		if item.id == "berry":
			if item.quantity > 1:
				print(item.quantity)
				item.quantity -= 1
				SignalManager.emit_signal("ate")
			elif item.quantity == 1:
				item.quantity -= 1
				remove_item()


func try_put_item(new_item: Item) -> bool: #Kollar om itemet får plats
	return new_item and not item or (item.id == new_item.id and item.quantity < item.stack_size)


func put_item(new_item: Item) -> Item: #Lägger dit item
	if new_item:
		if item:
			if item.id == new_item.id and item.quantity < item.stack_size: #Kollar om det redan finns item eller om det är en ny
				var remainder = item.add_item_quantity(new_item.quantity)
				if remainder < 1:
					return null
				
			else: #Ifall den är ny
				var temp_item = item
				item_container.remove_child(item)
				set_item(new_item)
				new_item = temp_item
			return new_item
		else:
			set_item(new_item)
			return null
	elif item:
		new_item = item
		set_item(null)
	return new_item


func remove_item_child():
	item_container.remove_child(item)


func remove_item():
	put_item(null)


func accept_item(new_item) -> bool:
	return new_item and not item


