extends Area2D

const VELOCITY = 600


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


func _on_Vapen_area_entered(area: Area2D) -> void:
	if area.is_in_group("Vapen"):
		queue_free()


func _on_Vapen_body_entered(body: Node) -> void:
	if body.is_in_group("enemy") or body.is_in_group("tree"):
		body.die()
		queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
