extends RigidBody2D

onready var explosion = $Particles2D
onready var explosion_trails = $Particles2D2
onready var sound = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	explosion.emitting = true
	explosion_trails.emitting = true
	sound.play()

#we could maybe do some rb.sleep optimization if this gets nasty :/
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	sleeping = true


func _on_VisibilityNotifier2D_screen_entered():
	sleeping = false
