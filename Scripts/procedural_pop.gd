extends Node2D

onready var rng = RandomNumberGenerator.new()
onready var asteroid_scn := preload("res://Scenes/Scenery/Asteroid.tscn")
onready var asteroid_rb_scn := preload("res://Scenes/Scenery/Asteroid_rb.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for y in range(14):
		for x in range(14):
			var rand = rng.randi_range(1, 10)
			if rand < 3:
				var asteroid_rb = asteroid_rb_scn.instance()
				get_tree().current_scene.add_child(asteroid_rb)
				asteroid_rb.global_position.y = (y-7) * 400
				asteroid_rb.global_position.x = (x-7) * 400
			if rand > 7:
				var asteroid = asteroid_scn.instance()
				get_tree().current_scene.add_child(asteroid)
				asteroid.global_position.y = (y-7) * 400
				asteroid.global_position.x = (x-7) * 400


#func _process(delta):
#	pass
