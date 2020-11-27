extends RigidBody2D

onready var explosion = $Particles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	explosion.emitting = true

#we could maybe do some rb.sleep optimization if this gets nasty :/
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
