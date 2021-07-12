extends KinematicBody2D
class_name Player

# State Machine
enum PlayerState {MOVIN,ATTACKIN,CASTIN,DEFEND,HURT,DEAD}
var state = PlayerState.MOVIN

# Logic
export(float) var FORCE  = 160.0
var ACC : float = FORCE * 4.0

var ATK_FORCE : float = FORCE * 8.0
var ATK_ACC : float = 4.0

var velocity : Vector2 = Vector2.ZERO
var last_dir : Vector2 = Vector2.LEFT

onready var atk_timer = $atk_timer

# Animation
onready var chr = $chr

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
	else:
		# IDLIN (for lamers)
		velocity = velocity.move_toward(Vector2.ZERO, cur_acc)
	
	if Input.is_action_just_pressed("attack"):
		state = PlayerState.ATTACKIN
		atk_timer.start()
	
	if Input.is_action_just_pressed("defend"):
		state = PlayerState.DEFEND
		atk_timer.start()
	
	if vel.x > 0.0:
		chr.scale.x = -1.0
	elif vel.x < 0.0:
		chr.scale.x = 1.0

func attack() -> void:
	velocity = last_dir * FORCE

func defend() -> void:
	velocity = Vector2.ZERO

func _physics_process(delta):
	match(state):
		PlayerState.MOVIN:
			move(delta)
		PlayerState.ATTACKIN:
			attack()
		PlayerState.DEFEND:
			defend()
	velocity = move_and_slide(velocity)

func _process(_delta) -> void:
	scale.x = (global_position.y / get_viewport().size.y) * 1.75
	scale.y = scale.x

# PLACEHOLDER UNTIL ANIM COMES ALONG!
func atk_timeout():
	state = PlayerState.MOVIN
