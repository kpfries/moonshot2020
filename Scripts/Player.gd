extends RigidBody2D


export var thrust = 50
onready var control = $PlayerControl
export var tether: NodePath = ""
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")

onready var ray = $PlayerControl/RayCast2D
onready var grapple = get_node(tether)
onready var gun = $PlayerControl/Gun

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cursor_pos = get_global_mouse_position()

	control.look_at(cursor_pos)
	
	#Input Handling
	if Input.is_action_pressed('ui_up'):
		var thruster_force = thrust * delta * self.position.direction_to(cursor_pos)
		self.apply_central_impulse(thruster_force)
		
	if Input.is_action_just_pressed("grapple"):
		if ray.is_colliding() == true:
			moveto(ray.get_collider(), grapple)
			grapple.set_node_b(get_path_to(ray.get_collider()))
			print(ray.get_collider().global_position)
	if Input.is_action_just_released("grapple"):
		if grapple.node_b:
			grapple.set_node_b(NodePath(""))
			
	#eventually check if equipped weapon is repeating and spawn another bullet when elapsed time exceeds firerate but for now we're doing semi auto
	if Input.is_action_just_pressed("shoot"):
		var bullet := bullet_scn.instance()
		bullet.vector = position.direction_to(cursor_pos)
		bullet.global_transform = gun.global_transform
		bullet.parent_speed = linear_velocity
		get_tree().current_scene.add_child(bullet)
			

func moveto(target, current):
	var target_pos = target.global_position
	var current_pos = current.global_position
	var translate_offset = target_pos - current_pos
	current.global_translate(translate_offset)
		
