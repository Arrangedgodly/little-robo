extends CanvasLayer

@export var health_manager: Node2D
@onready var heart_container: HBoxContainer = $HeartContainer

const HEART = preload("res://assets/heart.png")
const HEART_BROKEN = preload("res://assets/heart_broken.png")

func _ready() -> void:
	for i in health_manager.current_health:
		var texture_rect = TextureRect.new()
		texture_rect.texture = HEART
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		heart_container.add_child(texture_rect)
	health_manager.damage.connect(_handle_health)
	health_manager.health_gain.connect(_handle_health)

func _handle_health() -> void:
	var i = health_manager.current_health
	for heart in heart_container.get_children():
		if i > 0:
			heart.texture = HEART
			i -= 1
		if i == 0:
			heart.texture = HEART_BROKEN
	pass
