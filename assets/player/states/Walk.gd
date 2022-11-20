extends MoveState

func enter() -> void:
	.enter()
	player.move_speed = player.walk_speed
	
func input(event: InputEvent) -> BaseState:
	var new_state = .input(event)
	if new_state:
		return new_state
		
	return null
