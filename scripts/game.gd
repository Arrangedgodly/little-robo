extends Node2D

@export var spawn_manager: Node2D
@export var level_manager: Node2D
@export var health_manager: Node2D
@export var player: CharacterBody2D

func _ready() -> void:
	health_manager.dead.connect(_reset_game)
	level_manager.death_zone_triggered.connect(_reset_game)
	level_manager.level_loaded.connect(spawn_manager.init)
	level_manager.clearing.connect(spawn_manager.disconnect_checkpoints)
	
	level_manager.load_level(level_manager.current_level)
	player.position = spawn_manager.spawn_pos
	
func _reset_game() -> void:
	print_debug("resetting game")
	level_manager.clear_level()
	get_tree().process_frame
	player.position = spawn_manager.spawn_pos
	level_manager.load_level(level_manager.current_level)
	health_manager.reset_health()
