extends KinematicBody2D
class_name Player

enum PlayerState {MOVIN,ATTACKIN}
var state = PlayerState.MOVIN

export(float) var FORCE  = 160.0
var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO

func axis() -> Vector2:
	var vert : float = Input.get_action_strength("down") - Input.get_action_strength("up")
	var horz : float = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(horz, vert).normalized()

func move(dt : float) -> void:
	var vel : Vector2 = axis()
	var cur_acc : float = ACC * dt
	
	if vel != Vector2.ZERO:
		velocity = velocity.move_toward(vel * FORCE, cur_acc)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, cur_acc)
	
	velocity = move_and_slide(velocity)

func attack() -> void:
	pass

func _process(delta) -> void:
	match(state):
		PlayerState.MOVIN:
			move(delta)
		PlayerState.ATTACKIN:
			attack()
	
	scale.x = (global_position.y / get_viewport().size.y) * 1.75
	scale.y = scale.x
