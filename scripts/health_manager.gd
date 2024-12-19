extends Node2D
signal damage
signal health_gain
signal dead

@export var player: CharacterBody2D
var max_health: int = 3
var current_health: int = 3

func _ready() -> void:
	player.took_damage.connect(lose_health)
	player.gain_health.connect(gain_health)

func lose_health() -> void:
	current_health -= 1
	if current_health == 0:
		dead.emit()
	else:
		damage.emit()
	
func gain_health() -> void:
	if current_health < max_health:
		current_health += 1
		health_gain.emit()
