extends RigidBody2D
class_name Weapon

export var on_ground : bool = false
export var weapon_name : String = "Weapon"
export var offset : Vector2 = Vector2.ZERO

var player: Player = null

onready var collider : CollisionShape2D = $CollisionShape2D
onready var player_detector : Area2D = $PlayerDetector

# ========== Events that are triggered by the player when equipped ===========
func pickup(new_player) -> void:
	on_ground = false
	call_deferred("set_pickup_physics")
	
func drop(pos: Vector2) -> void:
	on_ground = true
	call_deferred("set_dropped_physics", pos)
	
func equip() -> void:
	pass
	
func unequip() -> void:
	pass

# Handle inputs for the weapon
func input(event: InputEvent) -> void:
	pass
	
# Where you would do updates that update the weapon's position relative to the character
func physics_process(delta: float) -> void:
	pass
	
func process(delta: float) -> void:
	pass
	
# ============================================================================

# Turns off collision for terrain and the player detector while the weapon is being held
func set_pickup_physics() -> void:
	player_detector.set_collision_mask_bit(9, false)
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	mode = RigidBody2D.MODE_KINEMATIC
	position = Vector2.ZERO
	
func set_dropped_physics(pos: Vector2) -> void:
	player_detector.set_collision_mask_bit(9, true)
	set_collision_layer_bit(1, true)
	set_collision_mask_bit(0, true)
	mode = RigidBody2D.MODE_RIGID
	position = pos

# When making a new weapon, create a signal linking PlayerDetector.body_entered(body), and
# call this function from within the signal function
func player_detector_enter(body):
	if !on_ground: return
	
	if body is Player:
		body.pickup_weapon(self)
