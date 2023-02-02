extends Area2D
var occupied = false

var piece

func _ready() -> void:
	global_position = get_parent().detection_ruta_pos
	


func _on_detection_ruta_body_entered(body: Node) -> void:
	if !body.is_in_group("curser"):
		piece = body
		occupied = true


func _on_Button_pressed() -> void:
	if occupied == true and piece.is_in_group("vit"):
		piece.selected()
