extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	global_position = Vector2(rng, rng)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
