extends "res://Scripts/Enemy.gd"

var bullets_remaining_G1: int = 0
var bullets_remaining_G2: int = 0

onready var gunlist = $EnemyController/Guns.get_children()
onready var fire_frequency_G1 = $EnemyController/Guns/Gun1/FireFrequencyG1
onready var ReloadTimer_G1 = $EnemyController/Guns/Gun1/ReloadTimerG1
onready var fire_frequency_G2 = $EnemyController/Guns/Gun2/FireFrequencyG2
onready var ReloadTimer_G2 = $EnemyController/Guns/Gun2/ReloadTimerG2


# Called when the node enters the scene tree for the first time.
func _ready():
	fire_frequency_G1.start()
	ReloadTimer_G1.start()
	ReloadTimer_G1.paused = true
	fire_frequency_G2.start()
	ReloadTimer_G2.start()
	ReloadTimer_G2.paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(player.global_position)
	gun_handler(gunlist)
	if player.global_position.distance_to(global_position) < detection_distance:
		velocity = velocity.linear_interpolate(chase(targetdistance) * speed, acceleration)
		fire_frequency_G1.paused = false
		fire_frequency_G2.paused = false
	else:
		velocity = velocity.linear_interpolate(Vector2(0,0), acceleration)
		fire_frequency_G1.paused = true
		fire_frequency_G2.paused = true
	velocity = move_and_slide(velocity)
	#gun_handler(gunlist)
#	pass

func gun_handler(guns):
	for gun in guns:
		gun.look_at(player.global_position)




#Gun Timing
func _on_FireFrequencyG1_timeout():
	if bullets_remaining_G1 > 0:
		shoot(gunlist[0])
		bullets_remaining_G1 -= 1
		fire_frequency_G1.start()
	else:
		ReloadTimer_G1.paused = false



func _on_ReloadTimerG1_timeout():
	bullets_remaining_G1 = clip_size
	ReloadTimer_G1.start()
	fire_frequency_G1.paused = true



func _on_FireFrequencyG2_timeout():
	if bullets_remaining_G2 > 0:
		shoot(gunlist[1])
		bullets_remaining_G2 -= 1
		fire_frequency_G2.start()
	else:
		ReloadTimer_G2.paused = false



func _on_ReloadTimerG2_timeout():
	bullets_remaining_G2 = clip_size
	ReloadTimer_G2.start()
	fire_frequency_G2.paused = true

