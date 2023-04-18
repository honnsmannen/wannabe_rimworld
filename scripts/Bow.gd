extends Sprite

const VELOCITY = 0


var direction := Vector2.ZERO

func _ready() -> void:
	$Timer.start()

func _physics_process(delta: float) -> void:
	if direction == Vector2.ZERO:
		return
	
	else:
		global_position += direction * VELOCITY * delta 


func set_direction(pos1: Vector2, pos2: Vector2) -> void:
	direction = (pos2 - pos1).normalized()
	rotation = direction.angle()

func _on_Timer_timeout() -> void:
	queue_free()
