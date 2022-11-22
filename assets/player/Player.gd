class_name Player
extends KinematicBody2D

export (NodePath) var camera_path

export var gravity = 4
export var walk_speed = 60
export var sprint_speed = 90
export var acceleration = 0.2
export var air_acceleration = 0.075
export var friction = 0.1
export var air_friction = 0.1
export var jump_height = 100
export var jump_time_to_peak = 0.5
export var jump_time_to_descent = 0.3
export var max_fall_speed = 200
export var dash_speed = 100
export var dash_length = 0.5

var velocity = Vector2.ZERO
var move_speed = 60
var camera_zone = null

onready var animations : AnimatedSprite = $AnimatedSprite
onready var states = $StateManager
onready var camera : Camera2D = get_node(camera_path)
onready var jump_velocity : float = (2.0 * jump_height) / jump_time_to_peak
onready var jump_gravity : float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
onready var fall_gravity : float = (2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

func _ready() -> void:
	$"StateManager/DashTimer".wait_time = dash_length
	states.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	states.input(event)
	
func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	check_camera()
	
func _process(delta: float) -> void:
	states.process(delta)
	
func check_camera() -> void:
	var physics = get_world_2d().get_direct_space_state()
	var points = physics.intersect_point(position, 1, [], 2147483647, false, true)
	for point in points:
		if point['collider'] != camera_zone:
			camera_zone = point['collider']
			camera.position = camera_zone.position
			#print("entering camera zone: %s (%s,%s)" % [camera_zone, camera_zone.position.x, camera_zone.position.y])
	
func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	return 0

# Returns the direction the player is facing
func facing_dir() -> int:
	if animations.flip_h:
		return -1
	else:
		return 1
		
func clamp_movement_speed(x: float, damping: float) -> float:
	if x > move_speed:
		x -= x * damping
		if x < move_speed:
			x = move_speed
	if x < -move_speed:
		x -= x * damping
		if x > -move_speed:
			x = -move_speed
	return x
	
func clamp_fall_speed(y: float, damping: float) -> float:
	if y > max_fall_speed:
		y -= y * damping
		if y > max_fall_speed:
			y = max_fall_speed
	return y
