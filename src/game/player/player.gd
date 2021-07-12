extends KinematicBody2D
class_name Player

# State Machine
enum PlayerState {MOVIN,ATTACKIN}
var state = PlayerState.MOVIN
# Logic
export(float) var FORCE  = 160.0
var ACC : float = FORCE * 4.0

var ATK_FORCE : float = FORCE * 32.0
var ATK_ACC : float = 16.0

var velocity : Vector2 = Vector2.ZERO
var last_dir : Vector2 = Vector2.ZERO

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
		velocity = velocity.move_toward(vel * FORCE, cur_acc)
		last_dir = vel
	else:
		velocity = velocity.move_toward(Vector2.ZERO, cur_acc)
	
	if Input.is_action_just_pressed("attack"):
		velocity = velocity.move_toward(last_dir * ATK_FORCE, cur_acc * ATK_ACC)
	
	velocity = move_and_slide(velocity)
	
	if vel.x > 0.0:
		chr.scale.x = 1.0
	elif vel.x < 0.0:
		chr.scale.x = -1.0

func attack() -> void:
	pass

func _physics_process(delta):
	match(state):
		PlayerState.MOVIN:
			move(delta)
		PlayerState.ATTACKIN:
			attack()

func _process(_delta) -> void:
	scale.x = (global_position.y / get_viewport().size.y) * 1.75
	scale.y = scale.x
