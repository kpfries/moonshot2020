extends "res://Scripts/Enemy.gd"

export var knockback: int = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 4
	speed = 500
	targetdistance = 0
	detection_distance = 1200
	acceleration = .05
	pass # Replace with function body.



func _physics_process(delta):
	look_at(player.global_position)
	if player.global_position.distance_to(global_position) < detection_distance:
		velocity = velocity.linear_interpolate(chase(targetdistance) * speed, acceleration)
		#fire_frequency.paused = false
	else:
		velocity = velocity.linear_interpolate(Vector2(0,0), acceleration)
		#fire_frequency.paused = true
	velocity = move_and_slide(velocity)

func die():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(5)
		body.apply_central_impulse(Vector2(1,0).rotated(rotation) * knockback)
		velocity -= Vector2(1,0).rotated(rotation) * knockback
	pass # Replace with function body.
