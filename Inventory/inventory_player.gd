extends Control

export(NodePath) onready var player_inventory = get_node(player_inventory) as Inventory

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("activate"):
		var inventories = [player_inventory]
		SignalManager.emit_signal("player_inventory_ready", inventories)

