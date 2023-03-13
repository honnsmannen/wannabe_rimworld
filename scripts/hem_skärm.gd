extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var spel = "res://scener/värld_för_navigation.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_avsluta_button_up():
	breakpoint


func _on_nyttspel_button_up():
	get_tree().change_scene(spel)
