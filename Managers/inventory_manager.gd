extends Node


var player_inventories : Array = []
var inventories : Array = []
var hotbar : Array = []
var item_in_hand : Item = null
var item_offset = Vector2.ZERO

onready var inventory_slot = preload("res://Inventory/inventory_slot.gd")

func _ready():
	SignalManager.connect("item_picked", self, "_on_item_picked")
	SignalManager.connect("player_inventory_ready", self, "_on_player_inventory_ready")
	SignalManager.connect("content_changed", self, "_on_inventory_content_changed")


func has_items(items_data, group_id) -> bool:
	for item_data in items_data:
		if get_item_count(item_data.id) < item_data.quantity:
			return false

	return true

#Antal items i stack
func get_item_count(id) -> int:
	var count = 0
	for inv in player_inventories:
		count += inv.get_item_count(id)
		print(count)
	return count

#kollar om det finns plats att lägga till item vid crafting
func has_space_for_items(items_data):
	var items = ItemManager.get_items(items_data)
	
	for inv in player_inventories:
		items = inv.try_place_stack_items(items)
	
	for inv in player_inventories:
		items = inv.accept_items(items)
	return items.size() <= 0

#plocka upp item
func _on_item_picked(item, sender):
	for i in player_inventories:
		item = i.add_item(item)
		if not item:
			sender.item_picked()
			return


func _on_player_inventory_ready(inv):
	player_inventories = inv


func add_items(items):
	for item in items:
		if item.stack_size > 1:
			for inv in player_inventories:
				item = inv.add_stack_item(item)
				if item == null: break
		if item:
			for inv in player_inventories:
				item = inv.add_item(item)
				if item == null: break


func remove_items(items) -> void:
	for item in items:
		for inv in player_inventories:
			item.quantity = inv.remove_item_quantity(item.id, item.quantity)
			if item.quantity == 0: break


func _on_inventory_content_changed(groups):
	SignalManager.emit_signal("inventory_group_content_changed", groups)
	



