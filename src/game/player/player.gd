extends KinematicBody2D
class_name Player

# State Machine
enum PlayerState {MOVIN, ATTACKIN, CASTIN, DEFEND, HURT, DEAD}
var state = PlayerState.MOVIN

# Logic
export(float) var FORCE  = 160.0
onready var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO
var last_dir : Vector2 = Vector2.LEFT

export(int) var health = 16
onready var max_health = health

# Animation
onready var chr = $chr
onready var avatar = $chr/avatar
onready var hit = $chr/hitbox/box

func axis() -> Vector2:
	var vert : float = Input.get_action_strength("down") - Input.get_action_strength("up")
	var horz : float = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(horz, vert).normalized()

func move(dt : float) -> void:
	var vel : Vector2 = axis()
	var cur_acc : float = ACC * dt
	
	if vel != Vector2.ZERO:
		# WALKIN
		velocity = velocity.move_toward(vel * FORCE, cur_acc)
		last_dir = vel
		avatar.play("walk")
	else:
		# IDLIN (for lamers)
		velocity = velocity.move_toward(Vector2.ZERO, cur_acc)
		avatar.play("default")
	
	if Input.is_action_just_pressed("attack"):
		state = PlayerState.ATTACKIN
		hit.disabled = false
		avatar.play("punch")
	
	if Input.is_action_just_pressed("defend"):
		state = PlayerState.DEFEND
		avatar.play("defend")
	
	if Input.is_action_just_pressed("cast"):
		state = PlayerState.CASTIN
		avatar.play("cast")
		Info.emit_signal("magic_cast", Info.MAGIC_ICE, Vector2(-chr.scale.x, 0) * FORCE, global_position)
	if vel.x > 0.0:
		chr.scale.x = -1.0
	elif vel.x < 0.0:
		chr.scale.x = 1.0

func attack() -> void:
	velocity = last_dir * (FORCE * 0.5)

func defend() -> void:
	velocity = Vector2.ZERO

func cast() -> void:
	velocity = Vector2.ZERO

# TODO: Properly have hurt stuff
func hurt() -> void:
	state = PlayerState.HURT
	avatar.play("hurt")

func _physics_process(delta):
	match(state):
		PlayerState.MOVIN:
			move(delta)
		PlayerState.ATTACKIN:
			attack()
		PlayerState.DEFEND:
			defend()
		PlayerState.CASTIN:
			cast()
	velocity = move_and_slide(velocity)

func anim_finish():
	match(state):
		PlayerState.ATTACKIN:
			hit.disabled = true
	state = PlayerState.MOVIN
	avatar.play("default")
