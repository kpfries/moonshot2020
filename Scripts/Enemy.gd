extends RigidBody2D

export var health: int = 5
export var thrust: int = 50
export var bullet_speed: int
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")
onready var controller = $EnemyController
onready var gun = $EnemyController/Gun
onready var fire_rate = $EnemyController/FireRate


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func choose_state():
	pass

func move(vector: Vector2):
	apply_central_impulse(vector)
	pass

func shoot():
	var bullet := bullet_scn.instance()
	bullet.vector = Vector2(1,0).rotated(controller.rotation)
	bullet.global_transform = gun.global_transform
	bullet.parent_speed = linear_velocity
	get_tree().current_scene.add_child(bullet)
	pass

func damage(dmg):
	health -= dmg
	if health < 1:
		die()

func die():
	#spawn corpse
	queue_free()
	pass
