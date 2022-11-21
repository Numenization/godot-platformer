class_name MoveState
extends BaseState

export (NodePath) var jump_node
export (NodePath) var fall_node
export (NodePath) var idle_node
export (NodePath) var walk_node

onready var jump_state: BaseState = get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state
		
	return null
	
func physics_process(delta: float) -> BaseState:
	# If the player is no longer on the ground, enter the falling state
	if !player.is_on_floor():
		return fall_state
	
	# Figure out what direction the player is inputting and flip our sprite accordingly
	var move = player.get_movement_input()
	if move < 0:
		player.animations.flip_h = true	
	elif move > 0:
		player.animations.flip_h = false
		
	# Apply gravity to player
	player.velocity.y += player.gravity
		
	# Move the player horizontally according to our input
	# With the help of the player.clamp_movementspeed() function:
	#  - The player will ramp up to move_speed using their acceleration
	#  - And will slow down if they're over move_speed using their friction
	var delta_x = 0
	if player.velocity.x * move < player.move_speed:
		delta_x = move * player.move_speed * player.acceleration
	player.velocity.x = player.clamp_movement_speed(player.velocity.x + delta_x, player.friction)
		
	# Apply our velocity
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	# If the player is not moving, return to idle state
	if move == 0:
		return idle_state
		
	return null
