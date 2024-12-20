extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal triggered(new_pos: Vector2)

var can_trigger: bool = true
var is_connected: bool = false

func _ready() -> void:
	add_to_group("checkpoint")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_trigger and is_connected:
		print_debug("checkpoint triggered")
		can_trigger = false
		sprite.play("trigger")
		triggered.emit(position)
		await sprite.animation_finished
		sprite.play("on")

func reset() -> void:
	print_debug("checkpoint reset")
	can_trigger = true
	sprite.play("off")

func set_active() -> void:
	print_debug("setting checkpoint active")
	can_trigger = false
	sprite.play("on")

func set_connected(connected: bool) -> void:
	is_connected = connected
