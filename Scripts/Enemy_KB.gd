extends KinematicBody2D

export var health: int = 5
export var speed: int = 300
export var targetdistance: int = 300
export var detection_distance = 700
export var acceleration: float = 0.2

var velocity: Vector2 = Vector2(0,0)
export var bullet_speed: int
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")
onready var gun = $EnemyController/Gun
onready var player = get_tree().get_nodes_in_group('Player')[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player.global_position.distance_to(global_position) < detection_distance:
		velocity = velocity.linear_interpolate(chase() * speed, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2(0,0), acceleration)
	velocity = move_and_slide(velocity)


func chase():
	look_at(player.global_position)
	var look_vec = 0
	if global_position.distance_to(player.global_position) >= targetdistance + 100:
		look_vec = Vector2(1,0).rotated(rotation)
	else:
		var std_look_vec = Vector2(1,0).rotated(rotation)
		var orth_look_vec = Vector2(1,0).rotated((rotation + PI/2))
		look_vec = orth_look_vec.linear_interpolate(std_look_vec, clamp((global_position.distance_to(player.global_position)-targetdistance)/100, 0.0, 1.0))
	return look_vec

		


func shoot():
	var bullet := bullet_scn.instance()
	bullet.vector = Vector2(1,0).rotated(rotation)
	bullet.global_transform = gun.global_transform
	bullet.parent_speed = Vector2(1,0).rotated(rotation) * velocity
	get_tree().current_scene.add_child(bullet)

func damage(dmg):
	health -= dmg
	if health < 1:
		die()
func die():
	#replace with rb corpse with linear_velocity set to velocity
	print('gottem')
	queue_free()
