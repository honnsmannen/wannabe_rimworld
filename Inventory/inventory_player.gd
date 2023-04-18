extends Control

export(NodePath) onready var player_inventory = get_node(player_inventory) as Inventory

func _ready() -> void:
	var inventories = [player_inventory]
	SignalManager.emit_signal("player_inventory_ready", inventories)
