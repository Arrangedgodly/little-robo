extends CharacterBody2D

var speed: int = 60
var move_direction = Vector2.LEFT
var can_die: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var floor_checker: RayCast2D = $FloorChecker
@onready var wall_checker: RayCast2D = $WallChecker
@onready var stomp_checker: Area2D = $StompChecker
@onready var label: Label = $Label

func _ready() -> void:
	stomp_checker.body_entered.connect(_on_stomp_checker_body_entered)
	stomp_checker.body_exited.connect(_on_stomp_checker_body_exited)
	label.hide()

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	if should_turn():
		turn_around()
	
	# Set horizontal movement
	velocity.x = speed * move_direction.x
	
	# Move and slide using built-in function
	move_and_slide()
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider and collider.is_in_group("player"):
				collider.take_damage()
	
	if can_die:
		var sprite_size = sprite.sprite_frames.get_frame_texture("walk", 0).get_size()
		var player = get_tree().get_first_node_in_group("player")
		if player.position.y < sprite_size.y:
			handle_stomp()
	
	# Update sprite direction
	update_sprite_direction()

func handle_stomp() -> void:
	speed = 0
	sprite.play("stomp")
	await get_tree().create_timer(.125).timeout
	collision_shape.disabled = true

func should_turn():
	# Only turn if we hit a non-player wall or about to walk off platform
	var wall_collision = wall_checker.get_collider()
	var hit_wall = wall_checker.is_colliding() and (not wall_collision or not wall_collision.is_in_group("player"))
	return hit_wall or not floor_checker.is_colliding()

func turn_around():
	# Flip the movement direction
	move_direction = -move_direction
	# Flip the wall checker's direction
	wall_checker.target_position.x = -wall_checker.target_position.x
	# Also update the floor checker's position to check ahead in the new direction
	floor_checker.position.x = abs(floor_checker.position.x) * move_direction.x

func update_sprite_direction():
	# Flip the sprite based on movement direction
	if move_direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _on_stomp_checker_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_die = true
		label.show()

func _on_stomp_checker_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_die = false
		label.hide()
