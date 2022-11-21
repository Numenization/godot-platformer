extends Node2D


func _process(delta):
	$DebugLabels.show_state(str($Player.get_node("StateManager").current_state))
	$DebugLabels.show_velocity(str($Player.velocity))
