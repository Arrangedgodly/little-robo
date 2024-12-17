extends Node2D

@export var spawn_manager: Node2D
@export var player: CharacterBody2D
@export var death_zone: Area2D

func _ready() -> void:
	player.position = spawn_manager.spawn_pos
	death_zone.kill.connect(_reset_game)
	
func _reset_game() -> void:
	player.position = spawn_manager.spawn_pos
