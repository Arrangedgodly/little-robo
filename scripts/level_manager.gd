extends Node2D
signal death_zone_triggered
signal level_loaded
signal clearing

var current_level: int = 1
var _is_transitioning: bool = false

func load_level(level_num: int) -> void:
	print_debug("Loading level")
	var level_path: String = "res://scenes/levels/level_" + str(level_num) + ".tscn"
	
	if not ResourceLoader.exists(level_path):
		push_error("Level " + str(level_num) + " does not exist at path: " + level_path)
		return
	
	var level_scene = load(level_path)
	if level_scene == null:
		push_error("Failed to load level " + str(level_num))
		return
		
	# Defer the instance creation and addition
	call_deferred("_deferred_load_level", level_scene, level_num)

# Add this new function to handle the deferred loading
func _deferred_load_level(level_scene: PackedScene, level_num: int) -> void:
	var level_instance = level_scene.instantiate()
	if level_instance == null:
		push_error("Failed to instantiate level " + str(level_num))
		return
		
	level_instance.triggered.connect(_on_level_death_zone_triggered)
	add_child(level_instance)
	current_level = level_num
	level_loaded.emit()

func increase_level() -> void:
	print_debug("increasing level")
	load_level(current_level + 1)

func clear_level() -> void:
	print_debug("clearing active level")
	clearing.emit()
	if get_children().size() > 0:
		for child in get_children():
			child.triggered.disconnect(_on_level_death_zone_triggered)
			child.queue_free()

func _on_level_death_zone_triggered() -> void:
	if _is_transitioning:
		return
	_is_transitioning = true
	print_debug("current level death zone triggered")
	death_zone_triggered.emit()
	_is_transitioning = false
