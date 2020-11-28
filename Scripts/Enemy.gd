extends KinematicBody2D





export var bullet_speed: int
export var clip_size: int = 10
var bullets_remaining: int = 0
var bullet_scn := preload("res://Scenes/Projectiles/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
