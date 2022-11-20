class_name Player
extends KinematicBody2D

export var gravity = 4
export var walk_speed = 60
export var sprint_speed = 90
export var friction = 0.1
export var air_friction = 0.1
export var jump_force = 100

var velocity = Vector2.ZERO
var move_speed = 60

onready var animations : AnimatedSprite = $AnimatedSprite
onready var states = $StateManager

func _ready() -> void:
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)
	
func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
func _process(delta: float) -> void:
	states.process(delta)
	
