extends Node2D


func _ready() -> void:
	ModerStockpile.stockpile_location(global_position)
	


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("filurer"):
		if body.carrying_item != "tom":
			ModerStockpile.add_item_to_stockpile(body.carrying_item , body.item_amount)
			
			body.item_dropped_off()
			#print("Stockpile: ", Stockpile)
			#print("value_of_item: ", value_of_item)
