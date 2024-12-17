extends Node2D

var spawn_pos: Vector2

func _ready() -> void:
	var checkpoints = get_tree().get_nodes_in_group("checkpoint")
	for checkpoint in checkpoints:
		checkpoint.triggered.connect(set_spawn)

func set_spawn(new_pos: Vector2) -> void:
	spawn_pos = new_pos
