class_name Resource_Manager extends Node
#Mellanhand för sprites och sånt
#Blir viktigare när det finns fler items

var sprites = {
	"wood": preload( "res://items/sprites/wood.png" ),
	"berry": preload( "res://items/sprites/berries.png" ),
	"stone": preload( "res://items/sprites/stone.png" ),

}

var fonts = {
	8: preload("res://font/font_8.tres")
}

var colors = {
	"normal": Color("905c32")
}

var tscn = {
	"floor_item": preload("res://items/floor_item.tscn")
}







