extends BaseState

export (NodePath) var jump_node
export (NodePath) var fall_node
export (NodePath) var walk_node
export (NodePath) var dash_node

onready var jump_state: BaseState = get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var dash_state: BaseState = get_node(dash_node)

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		if $"../DashCooldown".time_left <= 0:
			if $"../DashInput".time_left > 0 and player.facing_dir() == player.get_movement_input():
				return dash_state
			else:
				$"../DashInput".start()
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state
	return null
	
func physics_process(delta: float) -> BaseState:
	player.velocity.y += player.gravity
	player.velocity.x -= player.velocity.x * player.friction
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if !player.is_on_floor():
		return fall_state
	
	return null
