extends BaseState

export (NodePath) var walk_node
export (NodePath) var idle_node

onready var walk_state: BaseState = get_node(walk_node)
onready var idle_state: BaseState = get_node(idle_node)

func enter() -> void:
	.enter()
	player.move_speed = player.walk_speed
	
func physics_process(delta: float) -> BaseState:
	var move = get_movement_input()
	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
		
	player.velocity.y += player.gravity
	if move != 0:
		player.velocity.x = move * player.move_speed
	else:
		player.velocity.x -= player.velocity.x * player.air_friction
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
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
