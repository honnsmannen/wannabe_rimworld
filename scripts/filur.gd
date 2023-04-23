extends KinematicBody2D

signal hp_updated(hp)
signal died()
signal damaged(hp)
signal hunger(hunger)

export( NodePath ) onready var zone = get_node(zone) as Area2D
export( NodePath ) onready var interact_labels = get_node(interact_labels) as Control

onready var vapen_scene = preload("res://scener/Vapen.tscn")
onready var enemy = preload("res://scener/fiender.tscn")
onready var bow_scene = preload("res://scener/Bow.tscn")
onready var arrow_scene = preload("res://scener/Arrow.tscn")
onready var light = get_node("NightLight")
export (int) var speed = 200
export(String) var crafting_list

var velocity = Vector2()
var dmg_amount = 25
var can_attack := true
var can_bow := false
var can_move := true
var arrow := true
var direction := Vector2.RIGHT
export( int ) var hunger = 50
export( int ) var hp = 50
var temp_item = ""
var active_item = "yxa"
var carrying_an_item = false
var item_amount = 0
var carrying_item = "tom"
var current_interactable

func _ready():
	SignalManager.connect("ate", self,  "_on_ate")
	SignalManager.connect("crossbow_obtained", self, "_on_crossbow_obtained")
	SignalManager.connect("out_of_arrows", self, "_on_out_of_arrows")
	SignalManager.connect("arrow_obtained", self, "_on_arrow_obtained")



signal crossbow_obtained()
signal arrow_shot()
signal out_of_arrows()
signal arrow_obtained()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right") and can_move:
		velocity.x += 1
		direction = Vector2.RIGHT
	if Input.is_action_pressed("left") and can_move:
		velocity.x -= 1
		direction = Vector2.LEFT
	if Input.is_action_pressed("down") and can_move:
		velocity.y += 1
		direction = Vector2.DOWN
	if Input.is_action_pressed("up") and can_move:
		velocity.y -= 1
		direction = Vector2.UP
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("Attack") and can_attack:
		_shoot()
	if Input.is_action_pressed("R_click") and can_bow and arrow:
		bow_shoot()

	if Input.is_action_just_pressed("craft"):
		can_move = false
		SignalManager.emit_signal("crafting_opened", crafting_list)

	if Input.is_action_just_pressed("close_crafting"):
		can_move = true
		print("yup")
		SignalManager.emit_signal("crafting_closed")

	if Input.is_action_pressed( "activate" ) and current_interactable:
		print("activate!")
		current_interactable.interact()
		
		
	if Input.is_action_just_pressed("switch_active_item"):
		active_item_switch()
		print("active_item: ", active_item)
		print("carrying_item: ", carrying_item)
		print("temp_item: ", temp_item)
	if Input.is_action_pressed( "eat" ) and current_interactable:
		pass #finns i inventory_slot.gd


	if Input.is_action_just_pressed("ui_down"):
		$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1,0.1)
	if Input.is_action_just_pressed("ui_up"):
		$Camera2D.zoom = $Camera2D.zoom + Vector2(0.1,0.1)
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	


func damage(dmg_amount):
	hp -= dmg_amount
	emit_signal("damaged", hp)
	if hp <= 0:
		died()
		
func died():
	get_tree().quit()


func _on_Zone_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		damage(dmg_amount)

func _shoot() -> void:
	can_attack = false
	$AttackTimer.start()

	var vapen_instance = vapen_scene.instance()
	vapen_instance.global_position = $Vapenspawn.global_position
	vapen_instance.set_direction($Vapenspawn.global_position, get_global_mouse_position())
	
	get_tree().get_root().add_child(vapen_instance)
func bow_shoot() -> void:
	can_bow = false
	SignalManager.emit_signal("arrow_shot")
	$BowTimer.start()

	var bow_instance = bow_scene.instance()
	var arrow_instance = arrow_scene.instance()
	bow_instance.global_position = $Vapenspawn.global_position
	bow_instance.set_direction($Vapenspawn.global_position, get_global_mouse_position())
	
	arrow_instance.global_position = $Vapenspawn.global_position
	arrow_instance.set_direction($Vapenspawn.global_position, get_global_mouse_position())
	
	
	get_tree().get_root().add_child(bow_instance)
	get_tree().get_root().add_child(arrow_instance)

func _on_AttackTimer_timeout() -> void:
	can_attack = true
	$AttackTimer.stop()



func _on_BowTimer_timeout() -> void:
	can_bow = true
	$BowTimer.stop()



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

func _on_HungerTimer_timeout() -> void:
	hunger = clamp(hunger, 2, 100)
	hunger -= 1
	emit_signal("hunger", hunger)
	if hunger == 0:
		$DamageTimer.start()
	
func _on_DamageTimer_timeout() -> void:
	damage(dmg_amount)


func _on_Zone_area_exited(area: Area2D) -> void:
	if current_interactable == area:
		if current_interactable.has_method("out_of_range"):
			current_interactable.out_of_range()
		
		interact_labels.hide()
		current_interactable = null


func _on_Zone_area_entered(area: Area2D) -> void:
	if not current_interactable:
		var overlapping_area = zone.get_overlapping_areas()
		
		if overlapping_area.size() > 0 and overlapping_area[ 0 ].has_method( "interact" ):
			current_interactable = overlapping_area[ 0 ]
			interact_labels.display( current_interactable )


func _on_ate():
	hunger += 20
	hp += 10
	if hp > 100:
		hp = 100
	if hunger > 100:
		hunger = 100

	emit_signal("hunger", hunger)
	emit_signal("damaged", hp)

func _on_crossbow_obtained():
	can_bow = true
	
func _on_arrow_obtained():
	arrow = true
func _on_out_of_arrows():
	arrow = false




