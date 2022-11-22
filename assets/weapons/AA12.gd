extends Weapon

export var num_pellets : int = 6
export var deg_spread : float = 0.1
export var fire_rate : float = 150

export (PackedScene) var projectile_packed: PackedScene

onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
onready var firing_timer : Timer = $FiringTimer

var firing = false

func _ready() -> void:
	# Convert the weapons fire rate from rounds/minute to seconds/round
	firing_timer.wait_time = 60 / fire_rate

func pickup(new_player: Player) -> void:
	.pickup(new_player)
	print("Picked up %s" % weapon_name)

func input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		firing = true
	elif event.is_action_released("fire"):
		firing = false

func physics_process(delta: float) -> void:
	position = offset
	if firing and firing_timer.time_left <= 0:
		fire(get_global_mouse_position())
	
func fire(target: Vector2):
	firing_timer.start()
	for i in num_pellets:
		var projectile = projectile_packed.instance() as Bullet
		get_tree().get_root().add_child(projectile)
		projectile.position = $Barrel.get_global_transform().origin
		projectile.direction = (target - projectile.position).normalized()
		projectile.direction = projectile.direction.rotated(deg2rad(rng.randf_range(-deg_spread, deg_spread)))
		projectile.velocity = projectile.direction * projectile.speed

func _on_player_detector_body_entered(body):
	player_detector_enter(body)
