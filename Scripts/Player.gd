extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var thrust = 50
onready var sprite = $Sprite
export var tether: NodePath = ""
onready var ray = $Sprite/RayCast2D
onready var grapple = get_node(tether)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var cursor_pos = get_viewport().get_mouse_position()
	var cursor_pos = get_global_mouse_position()
	sprite.look_at(cursor_pos)
	
	#Input Handling
	if Input.is_action_pressed('ui_up'):
		var thruster_force = thrust * delta * self.position.direction_to(cursor_pos)
		self.apply_central_impulse(thruster_force)
		
	if Input.is_action_just_pressed("grapple"):
		print(ray.get_collider())
		if ray.is_colliding() == true:
			#var target_pos = ray.get_collider().global_position
			moveto(ray.get_collider(), grapple)
			grapple.set_node_b(get_path_to(ray.get_collider()))
			print(ray.get_collider().global_position)
			print(grapple.global_position)
	if Input.is_action_just_released("grapple"):
		if grapple.node_b:
			grapple.set_node_b(NodePath(""))
			
			

func moveto(target, current):
	var target_pos = target.global_position
	var current_pos = current.global_position
	var translate_offset = target_pos - current_pos
	current.global_translate(translate_offset)
		
