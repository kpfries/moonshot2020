extends Area2D


export var speed: float = 1000
var vector = Vector2(0, -1)
var parent_speed: Vector2 = Vector2()


func _ready():
	rotation = vector.angle()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += ((speed * vector) + parent_speed) * delta




func _on_Bullet_body_entered(body):
	print(body)
	queue_free()


func _on_Lifetime_timeout():
	queue_free()
