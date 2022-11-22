extends Weapon

export var weapon_name : String = "AA12"
export var offset : Vector2 = Vector2.ZERO

export var num_pellets : int = 6
export var deg_spread : float = 0.1

export (PackedScene) var projectile_packed: PackedScene

onready var player_detector : Area2D = $PlayerDetector

var rng = RandomNumberGenerator.new()

func pickup(player: Player) -> void:
	.pickup(player)
	print("Picked up %s" % weapon_name)

func input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		for i in 5:
			var projectile = projectile_packed.instance() as Bullet
			get_tree().get_root().add_child(projectile)
			projectile.position = $Barrel.get_global_transform().origin
			projectile.direction = (get_viewport().get_mouse_position() - projectile.position).normalized()
			projectile.direction = projectile.direction.rotated(deg2rad(rng.randf_range(-deg_spread, deg_spread)))
			projectile.velocity = projectile.direction * projectile.speed
			print("fire")

func physics_process(delta: float) -> void:
	position = offset

func set_pickup_physics() -> void:
		player_detector.set_collision_mask_bit(9, false)
		set_collision_layer_bit(1, false)
		set_collision_mask_bit(0, false)
		mode = RigidBody2D.MODE_KINEMATIC
		position = Vector2.ZERO

func _on_Area2D_body_entered(body):
	if !on_ground: return
	
	if body is Player:
		call_deferred("set_pickup_physics")
		body.pickup_weapon(self)
