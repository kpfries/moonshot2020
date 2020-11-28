extends Node2D

export var asteroid_density = 600
export var enemy_density = 1200
onready var random = RandomNumberGenerator.new()
onready var asteroid_scn := preload("res://Scenes/Scenery/Asteroid.tscn")
onready var enemy_kb := preload("res://Scenes/Actors/Enemy_KB.tscn")
onready var level_bounds = $LevelBounds.polygon
onready var pds = PoissonDiscSampling.new()
var game_seed: String = "seed"




func _ready():
	populate_asteroids(random)
	populate_enemies(random)

func populate_asteroids(rng):
	rng.seed = game_seed.hash()
	var points = pds.generate_points(asteroid_density, level_bounds, 3, Vector2(0,0))
	for point in points: 
		var asteroid = asteroid_scn.instance()
		asteroid.position = point
		get_tree().current_scene.add_child(asteroid)
		
func populate_enemies(rng):
	rng.seed = game_seed.hash()/2
	var points = pds.generate_points(enemy_density, level_bounds, 3, Vector2(0,0))
	for point in points: 
		var enemy = enemy_kb.instance()
		enemy.position = point
		get_tree().current_scene.add_child(enemy)
