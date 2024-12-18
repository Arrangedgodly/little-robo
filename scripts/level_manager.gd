extends Node2D

var current_level: int = 1

func load_level(level_num: int) -> void:
	var level_path: String = "res://scenes/levels/level_" + str(level_num) + ".tscn"
	
	if not ResourceLoader.exists(level_path):
		push_error("Level " + str(level_num) + " does not exist at path: " + level_path)
	
	var level_scene = load(level_path)
	if level_scene == null:
		push_error("Failed to load level " + str(level_num))
	
	var level_instance = level_scene.instantiate()
	if level_instance == null:
		push_error("Failed to instantiate level " + str(level_num))
	add_child(level_instance)
	
	current_level = level_num

func increase_level() -> void:
	load_level(current_level + 1)

func clear_level() -> void:
	if get_children().size() > 0:
		for child in get_children():
			child.queue_free()
