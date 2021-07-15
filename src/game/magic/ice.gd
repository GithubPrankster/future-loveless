extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO

func _physics_process(_delta):
	velocity = move_and_slide(velocity)

func body_entered(_body):
	queue_free()

func area_entered(_area):
	queue_free()
