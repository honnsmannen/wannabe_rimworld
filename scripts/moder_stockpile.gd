extends Node2D

var stockpile = {"yxa": 0}
#var value_of_item = 

"""
viktigt att itemkeys finns i moder_stockpiles Stockpile dictionary!!!
"""

func	 add_item_to_stockpile(item_id) -> void:
	stockpile[item_id] = stockpile[item_id] + 1
	print("stockpile: ", stockpile)
