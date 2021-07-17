extends KinematicBody2D

# Anim
onready var knock_timer = $knockback
onready var anim = $anim

# Logic
export(int, 8, 32) var health : int = 16
onready var max_health = health

export(float) var FORCE  = 320.0
onready var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO

enum EnemyState{MOVIN, STUNNED}
var state = EnemyState.MOVIN

var player = null

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, ACC * delta)
	velocity = move_and_slide(velocity)

func hurt_func(area):
	if state == EnemyState.MOVIN:
		var knock = (global_position - area.global_position).normalized().x
		velocity = Vector2(knock, 0.0) * FORCE
		
		state = EnemyState.STUNNED
		knock_timer.start()
		
		health -= area.attack
		if health <= 0:
			anim.play("death")
			yield(anim, "animation_finished")
			queue_free()

func knock_timeout():
	state = EnemyState.MOVIN

