extends Node
#Mellanhand för signaler

# Inventory
signal inventory_ready(inventory)
signal player_inventory_ready(inventories)
signal item_dropped(item)
signal content_changed(groups)
signal inventory_group_content_changed(groups)

signal crafting_opened(crafting_list_id)
signal crafting_closed()

signal item_picked(item)
#signal active_hotbar_key(key)

signal crossbow_obtained()
signal arrow_shot()
signal out_of_arrows()
signal arrow_obtained()

signal bush_sprite_changed(state)
signal building()
signal out_of_plank()
signal plank_placed()
signal ate()

