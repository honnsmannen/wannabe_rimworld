extends Node


var player_inventories : Array = []
var inventories : Array = []
var hotbar : Array = []
var item_in_hand : Item = null
var item_offset = Vector2.ZERO

func _ready():
	SignalManager.connect("item_picked", self, "_on_item_picked")
	SignalManager.connect("inventory_ready", self, "_on_inventory_ready")
	SignalManager.connect("player_inventory_ready", self, "_on_player_inventory_ready")

func _on_inventory_ready(inventory):
	inventories.append(inventory)
"""
	for slot in inventory.slots:
		slot.connect( "mouse_entered", self, "_on_mouse_entered_slot", [ slot ] )
		slot.connect( "mouse_exited", self, "_on_mouse_exited_slot" )
		slot.connect( "gui_input", self, "_on_gui_input_slot", [ slot ] )
"""
func _on_item_picked( item, sender ):
	#print("item picked")
	print(item)
	for i in player_inventories:
		item = i.add_item( item )
		if not item:
			sender.item_picked()
			return

func _on_player_inventory_ready( inv ):
	player_inventories = inv
