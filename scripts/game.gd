extends Node2D

@export var spawn_manager: Node2D
@export var level_manager: Node2D
@export var health_manager: Node2D
@export var player: CharacterBody2D
@export var death_zone: Area2D

func _ready() -> void:
	player.position = spawn_manager.spawn_pos
	
	death_zone.kill.connect(_reset_game)
	player.took_damage.connect(_on_player_took_damage)
	player.gain_health.connect(_on_player_gain_health)
	health_manager.dead.connect(_reset_game)
	
	level_manager.load_level(1)
	
func _reset_game() -> void:
	player.position = spawn_manager.spawn_pos
	level_manager.clear_level()

func _on_player_took_damage() -> void:
	health_manager.lose_health()

func _on_player_gain_health() -> void:
	health_manager.gain_health()
