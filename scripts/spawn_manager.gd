extends Node2D

var spawn_pos: Vector2 = Vector2(0, -32)
var checkpoints: Array = []

func init() -> void:
	# Disconnect any existing checkpoints first
	disconnect_checkpoints()
	
	# Get new checkpoints
	checkpoints = get_tree().get_nodes_in_group("checkpoint")
	
	# Connect to new checkpoints and check for active checkpoint
	for checkpoint in checkpoints:
		checkpoint.set_connected(true)
		checkpoint.triggered.connect(set_spawn)
		
		# If this checkpoint is at the current spawn position, activate it
		if checkpoint.position == spawn_pos:
			checkpoint.set_active()

func set_spawn(new_pos: Vector2) -> void:
	reset_spawn(spawn_pos)
	spawn_pos = new_pos
	print_debug("set spawn")

func reset_spawn(pos: Vector2) -> void:
	print_debug("reset spawn")
	for checkpoint in checkpoints:
		if is_instance_valid(checkpoint) and checkpoint.position == pos:
			checkpoint.reset()

func disconnect_checkpoints() -> void:
	print_debug("disconnecting checkpoints")
	for checkpoint in checkpoints:
		if is_instance_valid(checkpoint):
			checkpoint.set_connected(false)
			if checkpoint.triggered.is_connected(set_spawn):
				checkpoint.triggered.disconnect(set_spawn)
	
	# Clear the checkpoints array
	checkpoints.clear()
