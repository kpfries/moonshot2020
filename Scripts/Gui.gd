extends Control

onready var fps_counter = $FPSCounter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	set_rotation(0)
	fps_counter.text = str(Engine.get_frames_per_second())
