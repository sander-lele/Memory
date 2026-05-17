extends CharacterBody2D

@export var speed = 180
@export var steer_force = 45.0

var acceleration : Vector2 = Vector2.ZERO
var angle : float = 0

func seek():
	var steer : Vector2 = Vector2.ZERO
	var desired : Vector2 = (get_global_mouse_position() - global_position).normalized() * speed
	steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	angle = velocity.angle()
	position += velocity * delta

func die():
	$CPUParticles2D.emitting = false
	$DeadParticle.emitting = true
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled",true)

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
