#class_name Inventory_Slot buggar ibland, bara starta spelet 
class_name Inventory_Slot

extends TextureRect

export(NodePath) onready var item_container = get_node(item_container) as Control
onready var no_berry = preload("res://items/sprites/berries_no_more.png")
onready var berry = preload("res://items/sprites/berries.png")


var key
var item: Item
var ready = false
var new_item

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
	
func eat(item):
	if item:
		if item.id == "berry":
			if item.quantity > 1:
				print(item.quantity)
				item.texture = berry
				item.quantity -= 1
				SignalManager.emit_signal("ate")
			else:
				item.texture = no_berry
				print(item.quantity)


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
	

func _input(event): #kod för att selecta slots i hotbaren, vi får se om jag gör nåt med den
	if event.is_action_pressed("hotbar_" + key):
		print("Used hotbar slot: ", key)
		print(item)
		SignalManager.emit_signal("active_hotbar_key", key)
