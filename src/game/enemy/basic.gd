extends KinematicBody2D

onready var knock_timer = $knockback

export(int, 8, 32) var health : int = 16

export(float) var FORCE  = 320.0
var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO
var knocked_back : bool = false

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, ACC * delta)
	velocity = move_and_slide(velocity)

func hurt_func(area):
	if !knocked_back:
		health -= 8
		if health <= 0:
			queue_free()
		else:
			var knock = (global_position - area.global_position).normalized().x
			velocity = Vector2(knock, 0.0) * FORCE
			knocked_back = true
			knock_timer.start()

func knock_timeout():
	knocked_back = false
