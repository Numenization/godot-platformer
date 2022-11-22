extends BaseState

export (NodePath) var fall_node
export (NodePath) var walk_node
export (NodePath) var idle_node
export (NodePath) var jump_node

onready var fall_state: BaseState = get_node(fall_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var idle_state: BaseState = get_node(idle_node)
onready var jump_state: BaseState = get_node(jump_node)

onready var dash_timer    : Timer = get_node("../DashTimer")
onready var dash_cooldown : Timer = get_node("../DashCooldown")
var dir = 0

func enter() -> void:
	.enter()
	dash_timer.start()
	dash_cooldown.start()
	if player.animations.flip_h:
		dir = -1
	else:
		dir = 1
		
func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		return jump_state
	return null
	
func physics_process(delta: float) -> BaseState:
	var move = player.get_movement_input()
	
	player.velocity.y += player.gravity
	player.velocity.x = dir * player.dash_speed
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if dash_timer.time_left <= 0:
		if player.is_on_floor():
			if move != 0:
				return walk_state
			else:
				return idle_state
		else:
			return fall_state
		
	return null
