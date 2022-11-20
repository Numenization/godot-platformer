extends Node2D


func _process(delta):
	$CanvasLayer.showmessage(str($Player.get_node("StateManager").current_state))
