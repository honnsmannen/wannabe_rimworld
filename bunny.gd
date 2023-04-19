extends KinematicBody2D

onready var idle_sprite = $Sprite

onready var walking_sprite = $AnimatedSprite

func _idle() -> void:
	idle_sprite.visible = true
	walking_sprite.visible = false
	
	
func _running() -> void:
	idle_sprite.visible = false
	walking_sprite.visible = true



func _on_detection_range_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_running()
		
		
