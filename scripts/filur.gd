extends KinematicBody2D

signal hp_updated(hp)
signal died()



onready var vapen_scene = preload("res://scener/Vapen.tscn")
onready var enemy = preload("res://scener/test_karaktär.tscn")
onready var light = get_node("NightLight")
export (int) var speed = 200
onready var hp = max_hp



var max_hp = 100
var velocity = Vector2()
var dmg_amount = 10
var can_attack := true
var direction := Vector2.RIGHT

var temp_item = ""
var active_item = "tom"
var carrying_an_item = false
var item_amount = 0
var carrying_item = "tom"


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
	if Input.is_action_just_pressed("switch_active_item"):
		active_item_switch()
		#"""
		print("active_item: ", active_item)
		print("carrying_item: ", carrying_item)
		print("temp_item: ", temp_item)
		#"""

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
	can_attack = true
	$AttackTimer.stop()
	
	
func item_picked_up(item_id : String, amount) -> void:
	if !carrying_an_item or carrying_item == item_id:
		carrying_item = item_id
		item_amount += amount
		carrying_an_item = true
		print(item_id)
	
	
#kod för att lämna items
func item_dropped_off() -> void:
	if carrying_an_item:
		item_amount = 0
		carrying_item = "tom"
		carrying_an_item = false

func active_item_switch() -> void:
	if active_item == "tom":
		active_item = carrying_item
		carrying_item = "tom"
	else:
		temp_item = active_item
		active_item = carrying_item
		carrying_item = temp_item
		temp_item = ""

	
func _on_Day_Night_night_tick(night) -> void:
	light.show()

func _on_Day_Night_day_tick(day) -> void:
	light.hide()
