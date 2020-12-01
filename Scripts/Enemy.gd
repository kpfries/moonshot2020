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
var bullets_remaining: int = 0
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")
onready var random = RandomNumberGenerator.new()

onready var player = get_tree().get_nodes_in_group('Player')[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func chase(target_distance):
	#look_at(player.global_position)
	var rotations = player.global_position.angle_to_point(global_position)
	var look_vec = 0
	if global_position.distance_to(player.global_position) >= target_distance + 100:
		look_vec = Vector2(1,0).rotated(rotations)
	else:
		var std_look_vec = Vector2(1,0).rotated(rotations)
		var orth_look_vec = Vector2(1,0).rotated((rotations + PI/2))
		look_vec = orth_look_vec.linear_interpolate(std_look_vec, clamp((global_position.distance_to(player.global_position)-target_distance)/100, 0.0, 1.0))
	return look_vec


func shoot(gun):
	var bullet := bullet_scn.instance()

	var spread = random.randf_range(0.0, bullet_spread) - bullet_spread/2
	bullet.vector = Vector2(1,0).rotated(gun.global_rotation + spread)
	bullet.global_transform = gun.global_transform
	bullet.parent_speed = velocity
	get_tree().current_scene.add_child(bullet)
	
func damage(dmg):
	health -= dmg
	if health < 1:
		die()

func die():
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
