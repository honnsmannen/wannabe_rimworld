class_name Item extends TextureRect

signal quantity_changed(quantity)

var id : String
var item_name : String


var stack_size : int = 1
var quantity : int = 1 setget set_quantity



var lbl_quantity
var item_slot setget set_slot

func _init(item_id, data):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	id = item_id
	item_name = data.name
	texture = ResourceManager.sprites[id]
	
	stack_size = data.stack_size

#Tar label från resourcemanager för att visa kvantitet
func _ready():
	lbl_quantity = ResourceManager.get_instance("quantity")
	add_child(lbl_quantity)
	lbl_quantity.quantity = quantity

#bestämmer kvantitet 
func set_quantity(value):
	quantity = value
	emit_signal("quantity_changed", quantity)
	
	if lbl_quantity:
		lbl_quantity.quantity = quantity
	
	if quantity <= 0:
		destroy()

#lägger till värdet av set_quantity
func add_item_quantity(value):
	var remainder = quantity + value - stack_size
	quantity = int(min(quantity + value, stack_size))
	set_quantity(quantity)
	return remainder


func set_slot(value):
	item_slot = value


func destroy():
	if item_slot:
		item_slot.remove_item()


func get_data():
	return {"id": id, "quantity": quantity}


