extends Label

var quantity setget set_quantity
#Label för antal items
func set_quantity(value):
	text = str(value)
	visible = value > 1
