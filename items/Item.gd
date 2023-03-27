class_name Item extends TextureRect

var id
var item_name
var stack_size : int = 1
var quantity : int = 1 setget set_quantity
var level : int = 1
var components = {}

var lbl_quantity

func _init(item_id, data):
	#Ger items deras namn och sådant
	id = item_id
	item_name = data.name
	level = data.level
	texture = ResourceManager.sprites[id]
	
	if data.has("stack_size"):
		stack_size = data.stack_size


func _ready():
	#skriver ut mängden av item
	lbl_quantity = Label.new()
	lbl_quantity.set("custom_fonts/font", ResourceManager.fonts[ 8 ])
	lbl_quantity.set("custom_colors/font_color", Color.black)
	add_child(lbl_quantity)
	set_quantity(quantity)

func set_quantity(value):#bestämmer mängden av item
	quantity = value
	
	if lbl_quantity:
		lbl_quantity.text = str(quantity)
		lbl_quantity.visible = quantity > 1

func add_item_quantity(value): #Lägger till till mängden av item
	var remainder = quantity + value - stack_size
	quantity = min(quantity + value, stack_size)
	set_quantity(quantity)
	return remainder

