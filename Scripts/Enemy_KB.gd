extends "res://Scripts/Enemy.gd"


var enemy_dead := preload("res://Scenes/Actors/Enemy_Dead.tscn")
onready var gun = $EnemyController/Gun
onready var fire_frequency = $EnemyController/Gun/FireFrequency
onready var ReloadTimer = $EnemyController/Gun/ReloadTimer





# Called when the node enters the scene tree for the first time.
func _ready():
	fire_frequency.start()
	ReloadTimer.start()
	ReloadTimer.paused = true
	random.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(player.global_position)
	if player.global_position.distance_to(global_position) < detection_distance:
		velocity = velocity.linear_interpolate(chase(targetdistance) * speed, acceleration)
		fire_frequency.paused = false
	else:
		velocity = velocity.linear_interpolate(Vector2(0,0), acceleration)
		fire_frequency.paused = true
	velocity = move_and_slide(velocity)





	


func die():
	var corpse = enemy_dead.instance()
	corpse.linear_velocity = velocity
	corpse.global_position = global_position
	get_tree().current_scene.add_child(corpse)
	print('gottem')
	queue_free()



func _on_FireFrequency_timeout():
	if bullets_remaining > 0:
		shoot(gun)
		bullets_remaining -= 1
		fire_frequency.start()
	else:
		ReloadTimer.paused = false


func _on_ReloadTimer_timeout():
	bullets_remaining = clip_size
	ReloadTimer.start()
	fire_frequency.paused = true


