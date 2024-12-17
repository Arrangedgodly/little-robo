extends AnimatedSprite2D

@onready var label: Label = $"../Label"

func _on_animation_changed() -> void:
	label.text = animation
