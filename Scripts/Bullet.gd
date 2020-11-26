extends Area2D


export var speed: float = 1800
var vector = Vector2()
var parent_speed: Vector2 = Vector2(0, 0)
var damage: int = 1

onready var collision_particle := preload("res://Scenes/Particles/asteroid_collision.tscn")

func _ready():
	rotation = vector.angle()
	vector = ((speed * vector) + parent_speed)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += vector * delta




func _on_Bullet_body_entered(body):
	if body.has_method('damage'):
		body.damage(damage)
	if body is StaticBody2D:
		var particle = collision_particle.instance()
		particle.global_position = global_position
		get_tree().current_scene.add_child(particle)
	print(body)
	
	queue_free()


func _on_Lifetime_timeout():
	queue_free()
