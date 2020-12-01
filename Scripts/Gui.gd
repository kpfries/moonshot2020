extends Control

onready var fps_counter = $FPSCounter
onready var player = get_tree().get_nodes_in_group('Player')[0]
onready var healthbar = $TextureProgress

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.min_value = 0
	healthbar.max_value = player.health
	pass # Replace with function body.


func _process(delta):
	healthbar.value = player.health
	set_rotation(0)
	fps_counter.text = str(Engine.get_frames_per_second())
