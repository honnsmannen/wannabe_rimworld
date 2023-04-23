class_name Inventory extends NinePatchRect

var inventory_slot_res = preload("res://inventory/inventory_slot.tscn")

export(String) var inventory_name
export(int) var size = 0 setget inventory_size

export(NodePath) onready var slot_container = get_node(slot_container) as Control


var slots:Array = []
var is_open = false
var groups:Array = []
var has_upgradable_items = false

signal content_changed()


func _ready():
	for s in slots:
		s.connect("item_changed", self, "_on_item_changed")
		slot_container.add_child(s)

	SignalManager.emit_signal("inventory_ready", self)
	SignalManager.connect("arrow_shot", self, "_on_arrow_shot")
	SignalManager.connect("plank_placed", self, "_on_plank_placed")
	


#sätter storleken
func inventory_size(value):
	size = value
	rect_min_size.y = 40 + (ceil(size/5.0) - 1) *22

	for s in size:
		var new_slot = inventory_slot_res.instance()
		slots.append(new_slot)

#Lägger till item i inventory
func add_item(item):
	item = add_item_stack(item)

	if item:
		for s in slots:
			if item.id == "bow":
				SignalManager.emit_signal("crossbow_obtained")
			if item.id == "arrow":
				SignalManager.emit_signal("arrow_obtained")
			if item.id == "plank":
				SignalManager.emit_signal("building")

			if s.try_put_item(item):
				item = s.put_item(item)
				if not item: break

	content_has_changed()
	return item

#Lägger till item i redan existerande stack
func add_item_stack(item):
	if item.stack_size > 1:
		for s in slots:
			if s.item and s.item.id == item.id and s.item.quantity < s.item.stack_size:
				item = s.put_item(item)
				if item == null: break
	return item

#Ser om det går att stacka
func try_place_stack_items(items:Array):
	for s in slots:
		if s.item and s.item.quantity < s.item.stack_size:
			var free_space=s.item.stack_size - s.item.quantity
			for i in range(items.size() -1, -1, -1):
				if s.item.id == items[i].id:
					if items[i].quantity <= free_space:
						free_space-=items[i].quantity
						items.remove(i)
					else:
						items[i].quantity -= free_space
						break
	return items


func accept_items(items:Array): 
	for s in slots:
		for i in range(items.size() -1, -1, -1):
			if s.accept_item(items[i]):
				items.remove(i)
				break
	return items


func get_item_count(id): #kollar antal items
	var count = 0
	for s in slots:
		if s.item and s.item.id == id:
			count += s.item.quantity
	return count


func remove_item_quantity(id,quantity): #tar bort items from inventory exempelvis när man craftar
	for s in range(slots.size()-1, -1, -1):
		if slots[s].item and slots[s].item.id==id:
			if quantity >= slots[s].item.quantity:
				quantity -= slots[s].item.quantity
				slots[s].item.quantity = 0
				slots[s].put_item(null)
				if id == "arrow":
					SignalManager.emit_signal("out_of_arrows")
				if id == "plank":
					SignalManager.emit_signal("out_of_plank")


			else:
				slots[s].item.quantity -= quantity
				content_has_changed()
				return 0
	content_has_changed()
	return quantity


func content_has_changed():
	SignalManager.emit_signal( "content_changed", groups )

func _on_item_changed():
	content_has_changed()

func _on_arrow_shot():
	remove_item_quantity("arrow", 1)
func _on_plank_placed():
	remove_item_quantity("plank", 1)
