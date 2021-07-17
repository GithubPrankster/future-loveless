extends KinematicBody2D

# Anim
onready var anim = $anim

# Logic
export(int, 8, 32) var health : int = 16
onready var max_health = health

export(float) var FORCE  = 320.0
onready var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO

# State Logic
enum EnemyState{IDLIN, MOVIN, ATTACK, STUNNED}
var state = EnemyState.IDLIN

var punching_range : bool = false
var cooled : bool = true
onready var cooldown = $cooldown

onready var area = $area
onready var chr = $chr
onready var avatar = $chr/avatar
onready var hitbox = $chr/hitbox/box

func movin(delta : float):
	if punching_range and cooled:
		state = EnemyState.ATTACK
		avatar.play("punch")
		hitbox.disabled = false
	else:
		hitbox.disabled = true
		var dir = (area.player.global_position - global_position).normalized()
		velocity = velocity.move_toward(dir * (FORCE * 0.1), ACC * delta)
		avatar.play("walk")
		if dir.x > 0:
			chr.scale.x = -1.0
		elif dir.x < 0:
			chr.scale.x = 1.0

func _physics_process(delta):
	match(state):
		EnemyState.IDLIN:
			velocity = Vector2.ZERO
			if area.is_player_active():
				state = EnemyState.MOVIN
		EnemyState.MOVIN:
			if area.is_player_active():
				movin(delta)
		EnemyState.STUNNED:
			velocity = velocity.move_toward(Vector2.ZERO, ACC * delta)
		EnemyState.ATTACK:
			velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)

func hurt_func(arear):
	if state != EnemyState.STUNNED:
		arear.get_node("box").set_deferred("disabled", true)
		var knock = (global_position - arear.global_position).normalized().x
		velocity = Vector2(knock, 0.0) * FORCE
		
		state = EnemyState.STUNNED
		avatar.play("hurt")
		
		health -= arear.attack
		if health <= 0:
			anim.play("death")
			yield(anim, "animation_finished")
			queue_free()

func anim_finish():
	match(state):
		EnemyState.ATTACK:
			hitbox.disabled = true
			punching_range = false
			cooled = false
			cooldown.start()
	state = EnemyState.MOVIN

func punch_signal(body):
	punching_range = true

func chill_pill():
	cooled = true
