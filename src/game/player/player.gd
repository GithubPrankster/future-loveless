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

onready var stats = $stats
var switched : bool = false

onready var hurtbox = $hurtbox/box

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
		hurtbox.disabled = true
		avatar.play("defend")
	
	if Input.is_action_just_pressed("switch"):
		switched = !switched
	
	if Input.is_action_just_pressed("cast"):
		if stats.mana > 0:
			state = PlayerState.CASTIN
			avatar.play("cast")
			print(switched, int(switched))
			Info.emit_signal("magic_cast", stats.powers[int(switched)], Vector2(-chr.scale.x, 0) * FORCE, global_position)
			stats.mana -= int(switched) + 1
	
	if vel.x > 0.0:
		chr.scale.x = -1.0
	elif vel.x < 0.0:
		chr.scale.x = 1.0

func attack() -> void:
	velocity = last_dir * (FORCE * 0.5)

func nothing() -> void:
	velocity = Vector2.ZERO

func hurt_entered(area):
	if area.name == "hitbox":
		var knock = (global_position - area.global_position).normalized().x
		velocity = Vector2(knock, 0.0) * FORCE
		
		state = PlayerState.HURT
		avatar.play("hurt")
		stats.health -= area.attack

func _physics_process(delta):
	match(state):
		PlayerState.MOVIN:
			move(delta)
		PlayerState.ATTACKIN:
			attack()
		PlayerState.DEFEND:
			nothing()
		PlayerState.CASTIN:
			nothing()
	velocity = move_and_slide(velocity)

func anim_finish():
	match(state):
		PlayerState.ATTACKIN:
			hit.disabled = true
		PlayerState.DEFEND:
			hurtbox.disabled = false
	state = PlayerState.MOVIN
	avatar.play("default")
