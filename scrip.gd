extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_state(text):
	$StateLabel.text = text
	$StateLabel.show()

func show_velocity(text):
	$VelocityLabel.text = text
	$VelocityLabel.show()
