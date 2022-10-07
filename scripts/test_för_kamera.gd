extends KinematicBody2D

var speed := 400

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	var velocity = direction * speed 
	

	
	if velocity != Vector2.ZERO:
		rotation = velocity.angle()
