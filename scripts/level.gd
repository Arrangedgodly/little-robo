extends Node2D
signal triggered

@onready var death_zone: Area2D = $DeathZone

func _ready() -> void:
	death_zone.body_entered.connect(_on_death_zone_body_entered)

func _on_death_zone_body_entered(body: Node2D) -> void:
	print_debug(self.name + " death zone entered")
	if body.is_in_group("player"):
		triggered.emit()
