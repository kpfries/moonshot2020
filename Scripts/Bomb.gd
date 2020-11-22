extends RigidBody2D

export var damage: int = 5
export var knockback: float = 1000

var parent_vector = Vector2(0,0)
onready var explosion_hb = $ExplosionArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
 position += parent_vector * delta

func explode():
	explosion_hb.monitoring = true
	print('boom')
	pass


func _on_Timer_timeout():
	explode()

#on collision with bomb_rb
func _on_Bomb_body_entered(body):
	explode()
	pass # Replace with function body.

#on collision with explosion area
func _on_ExplosionArea_body_entered(body):
	var vector = (body.global_position - global_position).normalized() * knockback
	if body is KinematicBody2D:
		body.velocity += vector
	elif body is RigidBody2D:
		body.apply_central_impulse(vector)
	if body.has_method("damage"):
		body.damage(damage)
	#play explosion animation
	queue_free()
		
