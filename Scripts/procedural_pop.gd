extends Node2D

export var asteroid_density = 600
export var enemy_density = 1200
onready var random = RandomNumberGenerator.new()
onready var asteroid_scn := preload("res://Scenes/Scenery/Asteroid.tscn")
onready var enemy_kb := preload("res://Scenes/Actors/Enemy_KB.tscn")
onready var enemy_melee := preload("res://Scenes/Actors/Melee_Enemy.tscn")
onready var enemy_boss = $Boss1
onready var player = $Player
onready var level_bounds = $LevelBounds.polygon
onready var pds = PoissonDiscSampling.new()
#var game_seed: String = "seed"




func _ready():
	random.randomize()
	populate_asteroids(random)
	populate_enemies(random)
	place_boss(random)

func populate_asteroids(rng):
	#rng.seed = game_seed.hash()
	var points = pds.generate_points(asteroid_density, level_bounds, 3, Vector2(0,0))
	for point in points: 
		var asteroid = asteroid_scn.instance()
		asteroid.position = point
		get_tree().current_scene.add_child(asteroid)
		
func populate_enemies(rng):
	#rng.seed = game_seed.hash()/2
	var points = pds.generate_points(enemy_density, level_bounds, 3, Vector2(0,0))
	for point in points: 
		if player.global_position.distance_to(point) > 1000:
			var enemy
			var enemy_type = rng.randi_range(1,10)
			if enemy_type < 3:
				enemy = enemy_melee.instance()
			else:
				enemy = enemy_kb.instance()
			enemy.position = point
			get_tree().current_scene.add_child(enemy)

func place_boss(rng):
	var boss_direction = rng.randf_range(0, 2 * PI)
	var boss_distance = rng.randi_range(6000, 9000)
	var boss_vector = Vector2(boss_distance, 0).rotated(boss_direction)
	enemy_boss.global_position = boss_vector
