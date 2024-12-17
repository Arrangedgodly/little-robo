extends Area2D
signal kill

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		kill.emit()
