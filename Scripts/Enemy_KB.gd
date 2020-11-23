extends KinematicBody2D

export var health: int = 5
export var speed: int = 300
export var targetdistance: int = 300
export var detection_distance = 1200
export var acceleration: float = 0.2
export var bullet_spread: float = 0.2

var velocity: Vector2 = Vector2(0,0)

export var bullet_speed: int
export var clip_size: int = 10
var bullets_remaining: int = 30
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")
var bomb_scn := preload("res://Scenes/Projectiles/Bomb.tscn")
onready var gun = $EnemyController/Gun
onready var fire_frequency = $EnemyController/Gun/FireFrequency
onready var ReloadTimer = $EnemyController/Gun/ReloadTimer
onready var bomber = $EnemyController/Bomber
onready var random = RandomNumberGenerator.new()

onready var player = get_tree().get_nodes_in_group('Player')[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	fire_frequency.start()
	ReloadTimer.start()
	ReloadTimer.paused = true
	random.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player.global_position.distance_to(global_position) < detection_distance:
		velocity = velocity.linear_interpolate(chase() * speed, acceleration)
		fire_frequency.paused = false
	else:
		velocity = velocity.linear_interpolate(Vector2(0,0), acceleration)
		fire_frequency.paused = true
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

	var spread = random.randf_range(0.0, bullet_spread) - bullet_spread/2
	bullet.vector = Vector2(1,0).rotated(rotation + spread)
	bullet.global_transform = gun.global_transform
	bullet.parent_speed = velocity
	get_tree().current_scene.add_child(bullet)
	

func damage(dmg):
	health -= dmg
	if health < 1:
		die()
func die():
	#replace with rb corpse with linear_velocity set to velocity
	print('gottem')
	queue_free()



func _on_FireFrequency_timeout():
	if bullets_remaining > 0:
		shoot()
		bullets_remaining -= 1
		fire_frequency.start()
	else:
		ReloadTimer.paused = false


func _on_ReloadTimer_timeout():
	bullets_remaining = clip_size
	ReloadTimer.start()
	fire_frequency.paused = true


#func _on_BombFrequency_timeout():
#	var backwards = Vector2(1,0).rotated(rotation + PI) * random.randf_range(20, 40)
#	var bomb := bomb_scn.instance()
#	bomb.global_position = bomber.global_position
#	bomb.linear_velocity = backwards
#	get_tree().current_scene.add_child(bomb)
