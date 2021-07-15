extends KinematicBody2D

var velocity : Vector2 = Vector2.ZERO

onready var anim = $anim

func _physics_process(_delta):
	velocity = move_and_slide(velocity)

func body_entered(_body):
	velocity = Vector2.ZERO
	anim.play("death")
	yield(anim,"animation_finished")
	queue_free()

func area_entered(_area):
	velocity = Vector2.ZERO
	anim.play("death")
	yield(anim,"animation_finished")
	queue_free()
