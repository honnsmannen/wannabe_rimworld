extends KinematicBody2D

signal hp_updated(hp)
signal died()

var vapen_scene = preload("res://scener/Vapen.tscn")
onready var player = $"../Filuren"
onready var enemy = $"../test_karaktär"
export (int) var speed = 200
onready var hp = max_hp

var max_hp = 100
var velocity = Vector2()
var dmg_amount = 10
var can_attack := true
var direction := Vector2.RIGHT

onready var iframe = $IFrame

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2.RIGHT
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2.LEFT
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2.DOWN
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2.UP
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("Attack") and can_attack:
		_shoot()
	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func damage(dmg_amount):
	hp -= dmg_amount
	if hp <= 0:
		died()
		
func died():
	print("dead lmao")

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		damage(dmg_amount)
		print(hp)
		
func _shoot() -> void:
	can_attack = false
	$AttackTimer.start()

	var vapen_instance = vapen_scene.instance()
	vapen_instance.global_position = $Vapenspawn.global_position
	vapen_instance.set_direction($Vapenspawn.global_position, get_global_mouse_position())
	
	get_tree().get_root().add_child(vapen_instance)

func _on_AttackTimer_timeout() -> void:
	print("timeout")
	can_attack = true
	$AttackTimer.stop()
