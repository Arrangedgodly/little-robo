extends Node2D
signal damage
signal health_gain
signal reset
signal dead

@export var player: CharacterBody2D
var max_health: int = 3
var current_health: int = 3

func _ready() -> void:
	player.took_damage.connect(lose_health)
	player.gain_health.connect(gain_health)

func lose_health() -> void:
	print_debug("losing health")
	if current_health > 0:
		current_health -= 1
		damage.emit()
		if current_health == 0:
			dead.emit()
	
func gain_health() -> void:
	print_debug("gaining health")
	if current_health < max_health:
		current_health += 1
		health_gain.emit()

func reset_health() -> void:
	current_health = max_health
	reset.emit()
