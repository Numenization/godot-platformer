extends BaseState

export (NodePath) var fall_node
export (NodePath) var walk_node
export (NodePath) var idle_node
export (NodePath) var dash_node

onready var fall_state: BaseState = get_node(fall_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var dash_state: BaseState = get_node(dash_node)

func enter() -> void:
	.enter()
	player.move_speed = player.walk_speed
	player.velocity.y = -player.jump_force
	
func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		if $"../DashCooldown".time_left <= 0:
			if $"../DashInput".time_left > 0 and player.facing_dir() == player.get_movement_input():
				return dash_state
			else:
				$"../DashInput".start()	
	return null
	
func physics_process(delta: float) -> BaseState:
	var move = get_movement_input()
	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
		
	player.velocity.y += player.gravity
	if move != 0:
		# Refer to horiz movement code in Move.gd
		var delta_x = 0
		if player.velocity.x * move < player.move_speed:
			delta_x = move * player.move_speed * player.air_acceleration
		player.velocity.x = player.clamp_movement_speed(player.velocity.x + delta_x, player.air_friction)
	else:
		player.velocity.x -= player.velocity.x * player.air_friction
		
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.velocity.y > 0:
		return fall_state
		
	if player.is_on_floor():
		if move != 0:
			return walk_state
		else:
			return idle_state
	
	return null
	
func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	return 0
