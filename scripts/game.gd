extends Node2D

@export var spawn_manager: Node2D

func _ready() -> void:
	print(spawn_manager.spawn_pos)
