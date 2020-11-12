extends Area2D


export var speed: float = 1000
var vector = Vector2(0, -1)
var parent_speed: Vector2 = Vector2()




func _ready():
	rotation = vector.angle()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _physics_process(delta):
	position += ((speed * vector) + parent_speed) * delta




func _on_Bullet_body_entered(body):
	print(body)
	#if body.name == "Player":
	queue_free()
