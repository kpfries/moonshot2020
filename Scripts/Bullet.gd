extends Area2D


export var speed: float = 500
var vector = Vector2(0, -1)



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _physics_process(delta):
	position.y -= speed * delta * vector.y
	position.x -= speed * delta * vector.x

