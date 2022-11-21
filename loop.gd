extends Node2D


func _process(delta):
	$DebugLabels.show_state("State: %s"                 % str($Player/StateManager.current_state))
	$DebugLabels.show_velocity("Velocity: %s"           % str($Player.velocity))
	$DebugLabels.show_dash_input("Dash Input: %s"       % str($Player/StateManager/DashInput.time_left))
	$DebugLabels.show_dash_timer("Dash Timer: %s"       % str($Player/StateManager/DashTimer.time_left))
	$DebugLabels.show_dash_cooldown("Dash Cooldown: %s" % str($Player/StateManager/DashCooldown.time_left))

