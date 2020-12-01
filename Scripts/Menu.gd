extends Control

onready var seed_string = $TextEdit

onready var game_level := preload("res://Scenes/Sample_Scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_up():
	# Remove the current level
	get_tree().change_scene("res://Scenes/Sample_Scene.tscn")
	pass

