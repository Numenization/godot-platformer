extends RigidBody2D
class_name Weapon

export var on_ground : bool = false
#var weapon_packed = preload("res://assets/weapons/AA12.tscn")

var player: Player = null

onready var collider : CollisionShape2D = $CollisionShape2D

# Functions that are triggered by the player when equipped
func pickup(player) -> void:
	on_ground = false
	
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
