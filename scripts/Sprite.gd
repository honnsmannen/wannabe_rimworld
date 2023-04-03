extends Sprite


var full = preload("res://sprites/berry_full_bush.png")
var less = preload("res://sprites/berryless_bush.png")


func _ready() -> void:
	set_texture(full)
	SignalManager.connect( "bush_sprite_changed", self, "_on_bush_sprite_changed" )
func _on_bush_sprite_changed(state):
	

	if state == full:
		set_texture(full)
	else:
		set_texture(less)
