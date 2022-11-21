extends Node2D


func _process(delta):
	$DebugLabels.show_state("State: %s" % str($Player.get_node("StateManager").current_state))
	$DebugLabels.show_velocity("Velocity: %s" %str($Player.velocity))
