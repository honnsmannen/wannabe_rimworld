extends Node


const WIDTH = 1024
const HEIGHT = 600

var enemy_scene = preload("res://scener/test_karaktär.tscn")

onready var player = get_parent().get_node("Filuren")
var can_spawn_enemy = false
func _ready() -> void:
	randomize()
	$Timer.wait_time = 3 + rand_range(-2, 2)
	
func num_of_enemies(num) -> int:
	num = len(get_tree().get_nodes_in_group("enemy"))
	return num <= 15
	
	


func _spawn_enemy() -> void:
	var enemy = enemy_scene.instance()
	var section = randi() % 4
	if section == 0:
		enemy.global_position = player.global_position + Vector2(-WIDTH/2 - 20, rand_range(-HEIGHT/2, HEIGHT/2))
	elif section == 1:
		enemy.global_position = player.global_position + Vector2(WIDTH/2 + 20, rand_range(-HEIGHT/2, HEIGHT/2))
	elif section == 2:
		enemy.global_position = player.global_position + Vector2(rand_range(-WIDTH/2, WIDTH/2), -HEIGHT/2 - 20)
	else:
		enemy.global_position = player.global_position + Vector2(rand_range(-WIDTH/2, WIDTH/2), HEIGHT/2 + 20)
	add_child(enemy)
	

func _on_Timer_timeout() -> void:
	var num = 0
	if can_spawn_enemy and num_of_enemies(num):
		_spawn_enemy()
		print("spawn")
		$Timer.wait_time = 3 + rand_range(-2, 2)


func _on_Day_Night_night_tick(night) -> void:
	can_spawn_enemy = true


func _on_Day_Night_day_tick(day) -> void:
	can_spawn_enemy = false
	print("day")
