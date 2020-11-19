extends RigidBody2D

export var health: int = 5
export var thrust: int = 250
export var bullet_speed: int
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")
onready var controller = $EnemyController
onready var gun = $EnemyController/Gun
onready var fire_rate = $EnemyController/FireRate
onready var Vis_not = $VisibilityNotifier2D
onready var player = get_tree().get_nodes_in_group('Player')[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	controller.look_at(player.global_position)
	var thruster_force = find_player(Vector2(1,0).rotated(controller.rotation)) * delta * thrust

	apply_central_impulse(thruster_force)


func find_player(player_dir):
	var current_vec = player_dir
	var p_direction_relative = (linear_velocity - player.linear_velocity).normalized()
	if p_direction_relative.x < 0:
		current_vec.x -= p_direction_relative.x
	if p_direction_relative.y < 0: 
		current_vec.y -= p_direction_relative.y
	return current_vec.normalized()
	
	pass

func shoot():
	var bullet := bullet_scn.instance()
	bullet.vector = Vector2(1,0).rotated(controller.rotation)
	bullet.global_transform = gun.global_transform
	bullet.parent_speed = linear_velocity
	get_tree().current_scene.add_child(bullet)

func damage(dmg):
	health -= dmg
	if health < 1:
		die()

func die():
	#spawn corpse
	queue_free()
