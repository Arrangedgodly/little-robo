extends Node2D

var spawn_pos: Vector2 = Vector2(-54, -16)
var checkpoints

func _ready() -> void:
	checkpoints = get_tree().get_nodes_in_group("checkpoint")
	for checkpoint in checkpoints:
		checkpoint.triggered.connect(set_spawn)

func set_spawn(new_pos: Vector2) -> void:
	reset_spawn(spawn_pos)
	spawn_pos = new_pos

func reset_spawn(pos: Vector2) -> void:
	for checkpoint in checkpoints:
		if checkpoint.position == pos:
			checkpoint.reset()
