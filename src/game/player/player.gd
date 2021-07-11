extends KinematicBody2D

export(float) var FORCE  = 160.0
var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO

func axis() -> Vector2:
	var vert : float = Input.get_action_strength("down") - Input.get_action_strength("up")
	var horz : float = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(horz, vert).normalized()

func _physics_process(delta) -> void:
	var vel : Vector2 = axis()
	if vel != Vector2.ZERO:
		velocity = velocity.move_toward(vel * FORCE, ACC * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACC * delta)
	
	move_and_slide(velocity)

func _process(_delta) -> void:
	scale.x = (global_position.y / get_viewport().size.y) * 1.75
	scale.y = scale.x
