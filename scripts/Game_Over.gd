extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var spel = "res://scener/värld_för_navigation.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("jag finns")


func _on_TextureButton_button_up() -> void:
	get_tree().quit()
	


func _on_TextureButton2_button_up() -> void:
	get_tree().change_scene(spel)
