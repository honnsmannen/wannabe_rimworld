extends InnerPanel

export (NodePath) onready var price_list = get_node(price_list) as VBoxContainer
export (NodePath) onready var produce_list = get_node(produce_list) as VBoxContainer
export (NodePath) onready var craft_btn = get_node(craft_btn) as Button

var price: Array
var produce: Array

func _ready():
	SignalManager.connect("inventory_group_content_changed", self, "_on_inventory_group_changed")

#Samlar all info gällande recepten dvs vad det kostar och vad man får
func set_info(recipe_id, price_items, produce_items):
	price = price_items
	produce = produce_items
	set_craft_button()
	
	for item_data in price_items:
		var price_node = ResourceManager.get_instance("item_quantity")
		price_list.add_child(price_node)
		var item = ItemManager.get_item(item_data.id)
		price_node.set_info(item, item_data.quantity)
	
	for item_data in produce_items:
		var produce_node = ResourceManager.get_instance("item_quantity")
		produce_list.add_child(produce_node)
		var item = ItemManager.get_item(item_data.id)
		produce_node.set_info(item, item_data.quantity)

func set_craft_button():
	var can_craft = InventoryManager.has_items(price, "crafting") and InventoryManager.has_space_for_items(produce)
	craft_btn.disabled = not can_craft

#Tar bort price items från inventory och lägger till produce items
func _on_craft_pressed():
	InventoryManager.remove_items(ItemManager.get_items(price))
	InventoryManager.add_items(ItemManager.get_items(produce))

func _on_inventory_group_changed(groups):
	set_craft_button()




