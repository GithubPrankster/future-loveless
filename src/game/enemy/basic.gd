extends KinematicBody2D

onready var knock_timer = $knockback
onready var anim = $anim

export(int, 8, 32) var health : int = 16

export(float) var FORCE  = 320.0
var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO

enum EnemyState{MOVIN, STUNNED}
var state = EnemyState.MOVIN

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, ACC * delta)
	velocity = move_and_slide(velocity)

func hurt_func(area):
	if state == EnemyState.MOVIN:
		var knock = (global_position - area.global_position).normalized().x
		velocity = Vector2(knock, 0.0) * FORCE
		
		state = EnemyState.STUNNED
		knock_timer.start()
		
		health -= 8
		if health <= 0:
			anim.play("death")
			yield(anim, "animation_finished")
			queue_free()

func knock_timeout():
	state = EnemyState.MOVIN
