extends CharacterBody2D

var speed: int = 60
var move_direction = Vector2.LEFT

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_checker: RayCast2D = $FloorChecker
@onready var wall_checker: RayCast2D = $WallChecker


func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	# Check what the wall checker hit
	var wall_collision = wall_checker.get_collider()
	
	# If we hit a wall but it's the player, don't turn around - continue moving towards them
	if wall_collision and wall_collision.is_in_group("player"):
		# Deal damage to player when touching them
		if wall_collision.has_method("kill"):
			wall_collision.kill()
	# Otherwise, check normal patrol behavior
	elif should_turn():
		turn_around()
	
	# Set horizontal movement
	velocity.x = speed * move_direction.x
	
	# Move and slide using built-in function
	move_and_slide()
	
	# Update sprite direction
	update_sprite_direction()

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
