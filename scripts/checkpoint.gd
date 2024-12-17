extends StaticBody2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
signal triggered(new_pos: Vector2)

var player: CharacterBody2D
var can_trigger: bool = true

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _on_body_entered(body: Node2D) -> void:
	if body == player and can_trigger:
		can_trigger = false
		sprite.play("trigger")
		triggered.emit(position)
		await sprite.animation_finished
		sprite.play("on")

func reset() -> void:
	can_trigger = true
	sprite.play("off")
