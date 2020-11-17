extends RigidBody2D


export var thrust = 50
export var health = 10
export var tether: NodePath = ""
export var tether_line_path: NodePath = ""
var tether_line: Node

var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")

var target_selection: Node

var collide: Node

onready var control = $PlayerControl
onready var target_sprite =  $Target
onready var rays = $PlayerControl/Rays.get_children()
onready var grapple = get_node(tether)
onready var gun = $PlayerControl/Gun


func _ready():
	tether_line = get_node(tether_line_path)
	pass


func _physics_process(delta):
	var cursor_pos = get_global_mouse_position()

	control.look_at(cursor_pos)
	
	#Input Handling
	if Input.is_action_pressed('ui_up'):
		var thruster_force = thrust * delta * self.position.direction_to(cursor_pos)
		self.apply_central_impulse(thruster_force)
		
	if Input.is_action_just_pressed("grapple"):
		collide = aim_assist()
		if collide != null:
			moveto(collide, grapple)
			grapple.set_node_b(get_path_to(collide))
	if Input.is_action_pressed("grapple"):
		if collide != null:
			draw_tether(collide)
	if Input.is_action_just_released("grapple"):
		if grapple.node_b:
			grapple.set_node_b(NodePath(""))
			tether_line.points = Array()
			
	#eventually check if equipped weapon is repeating and spawn another bullet when elapsed time exceeds firerate but for now we're doing semi auto
	if Input.is_action_just_pressed("shoot"):
		var bullet := bullet_scn.instance()
		bullet.vector = position.direction_to(cursor_pos)
		bullet.global_transform = gun.global_transform
		bullet.parent_speed = linear_velocity
		get_tree().current_scene.add_child(bullet)
		
# warning-ignore:unused_argument
func _process(delta):

	pass
	
	#this should maybe be in a GUI controller later :/
	var target = aim_assist()
	if target != null:
		target_sprite.global_position = target.global_position
		target_sprite.global_rotation = 0

		target_sprite.visible = true
	else:
		target_sprite.visible = false
#
#
#	pass
	
			

func moveto(target, current):
	var target_pos = target.global_position
	var current_pos = current.global_position
	var translate_offset = target_pos - current_pos
	current.global_translate(translate_offset)
	
func aim_assist():
	for ray in rays:
		if ray.is_colliding():
			return ray.get_collider()

func damage(dmg):
	health -= dmg
	#activate oneshot particle system for blood uwu
	
func draw_tether(grappled):
	tether_line.global_position = Vector2(0,0)
	tether_line.global_rotation = 0
	tether_line.points = [global_position, grappled.global_position]
	
	
	
	
	
	
		
