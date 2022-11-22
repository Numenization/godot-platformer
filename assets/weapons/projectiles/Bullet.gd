extends Node2D
class_name Bullet

var direction : Vector2 = Vector2.ZERO
var speed : float = 300

var velocity = Vector2.ZERO

onready var lifetime_timer : Timer = $LifetimeTimer

func init() -> void:
	lifetime_timer.start()

func _physics_process(delta):
	look_at(position + velocity)
	position += velocity * delta

func _on_Hitbox_body_entered(body):
	self.queue_free()


func _on_LifetimeTimer_timeout():
	self.queue_free()
