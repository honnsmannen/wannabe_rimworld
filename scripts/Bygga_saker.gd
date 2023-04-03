extends Node2D

onready var healthbar = $CanvasLayer/HealthBar
onready var hungerbar = $CanvasLayer/HungerBar
#onready var scoretext = $ScoreText
onready var cell = null
onready var new_abc = 0
onready var tilemap = get_parent().get_node("TileMap")
onready var player = get_parent().get_node("Filuren")
var building = false

var score: int = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.value = player.hp
	hungerbar.value = player.hunger


func _process(delta):
	#SignalManager.connect("eating", hp, hunger, "_on_eating")
	var mouse :Vector2 = get_global_mouse_position()
	var cell :Vector2 = tilemap.world_to_map(mouse)
	var abc :int = tilemap.get_cellv(cell)
	
	if Input.is_action_just_pressed("click") and building == true:
		tilemap.set_cellv(cell, new_abc)
	#pass

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
	if building == true:
		new_abc = 1
		print("golv")


func _on_avp_building_pressed():
	if building == false:
		building = true
	else:
		building = false


func _on_avp_vgg_pressed():
	if building == true:
		new_abc = 2
		print("vägg")


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
		
		
"""
func _scoreUpdated(amount) -> void:
	score += amount
	scoretext.text = "Score: " + str(score)
"""
