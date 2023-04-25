extends Node2D

onready var healthbar = $CanvasLayer/HealthBar
onready var hungerbar = $CanvasLayer/HungerBar
#onready var scoretext = $ScoreText
onready var cell = null
onready var new_abc = 0
onready var tilemap = get_parent().get_node("bygg_tilemap")
onready var player = get_parent().get_node("Filuren")
var building = false
var has_planks = false
var score: int = 0




func _ready():
	healthbar.value = player.hp
	hungerbar.value = player.hunger
	SignalManager.connect("building", self, "_on_building")
	SignalManager.connect("out_of_plank", self, "_on_out_of_plank")


func _process(delta):
	var mouse :Vector2 = get_global_mouse_position()
	var cell :Vector2 = tilemap.world_to_map(mouse)
	var abc :int = tilemap.get_cellv(cell)
	

	
	if Input.is_action_just_pressed("click") and building and has_planks:
		tilemap.set_cellv(cell, 0)
		SignalManager.emit_signal("plank_placed")
	if Input.is_action_just_pressed("right_click"):
		tilemap.set_cellv(cell, -1)

func _on_Button_pressed() -> void:
	if building == false:
		building = true
	else:
		building = false


func _on_avp_vatten_pressed():
	if building == true:
		new_abc = 0
		print("vatten")


func _on_avp_golv_pressed():
	if has_planks:
		building = true
	else:
		building = false


func _on_avp_building_pressed():
	if building == false:
		building = true
	else:
		building = false


func _on_plank_pressed():
	if building == false:
		building = true
	else:
		building = false


func _on_Filuren_damaged(hp) -> void:
	if healthbar.value > hp:
		healthbar.value = hp
	elif healthbar.value < hp:
		healthbar.value = hp


func _on_Filuren_hunger(hunger) -> void:
	if hungerbar.value > hunger:
		hungerbar.value = hunger
	elif hungerbar.value < hunger:
		hungerbar.value = hunger
		

func _on_building():
	print("we buildnig")
	has_planks = true

func _on_out_of_plank():
	print("no building")
	has_planks = false
	building = false

"""
func _scoreUpdated(amount) -> void:
	score += amount
	scoretext.text = "Score: " + str(score)
"""
