extends KinematicBody2D


var x_step = 64
var y_step = 64

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		y_step += 64
		global_position = Vector2(x_step,y_step)
		
	elif Input.is_action_just_pressed("up"):
		y_step -= 64
		global_position = Vector2(x_step,y_step)
		
	elif Input.is_action_just_pressed("left"):
		x_step -= 64
		global_position = Vector2(x_step,y_step)
		
	elif Input.is_action_just_pressed("right"):
		x_step += 64
		global_position = Vector2(x_step,y_step)
		
