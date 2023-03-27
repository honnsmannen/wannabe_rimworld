extends Node2D

var stockpile = {"yxa": 0}
#var value_of_item = 
var stockpile_locations = []

"""
viktigt att itemkeys finns i moder_stockpiles Stockpile dictionary!!!
"""

func	 add_item_to_stockpile(item_id : String , amount : int) -> void:
	stockpile[item_id] = stockpile[item_id] + amount
	#print("stockpile: ", stockpile)


func stockpile_location(stockpile_cords) -> void:
	stockpile_locations.append(stockpile_cords)
	#print(stockpile_locations)
