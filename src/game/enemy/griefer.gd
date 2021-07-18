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
enum EnemyState{IDLIN, ATTACK, STUNNED}
var state = EnemyState.IDLIN

var cooled : bool = false
onready var cooldown = $cooldown

onready var area = $area
onready var chr = $chr
onready var avatar = $chr/avatar
onready var hitbox = $chr/hitbox/box

func movin(delta : float):
	if cooled:
		state = EnemyState.ATTACK
		var dir = (area.player.global_position - global_position).normalized()
		velocity = velocity.move_toward(dir * (FORCE * 4.0), (ACC * 24.0) * delta)
		avatar.play("punch")
		if dir.x > 0:
			chr.scale.x = -1.0
		elif dir.x < 0:
			chr.scale.x = 1.0
		hitbox.disabled = false
	else:
		hitbox.disabled = true

func _physics_process(delta):
	match(state):
		EnemyState.IDLIN:
			if area.is_player_active():
				movin(delta)
	velocity = velocity.move_toward(Vector2.ZERO, ACC * delta)
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
			Info.emit_signal("enemy_ded")
			queue_free()

func anim_finish():
	match(state):
		EnemyState.ATTACK:
			hitbox.disabled = true
			cooled = false
			cooldown.start()
		EnemyState.STUNNED:
			cooled = false
			cooldown.start(2.0)
	state = EnemyState.IDLIN
	avatar.play("default")

func chill_pill():
	cooled = true
