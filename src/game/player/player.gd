extends KinematicBody2D

export(float) var FORCE  = 160.0
var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO
var motion : Vector2 = Vector2.ZERO

func axis() -> Vector2:
	var vert : float = Input.get_action_strength("down") - Input.get_action_strength("up")
	var horz : float = Input.get_action_strength("right") - Input.get_action_strength("left")
	return Vector2(horz, vert)

func norm_axis() -> Vector2:
	return axis().normalized()

func friction(val : float) -> void:
	if motion.length() > val:
		motion -= motion.normalized() * val
	else:
		motion = Vector2.ZERO

func movement(val : Vector2) -> void:
	motion += val
	motion = motion.clamped(FORCE)

func _physics_process(delta) -> void:
	var vel : Vector2 = norm_axis()
	if vel == Vector2.ZERO:
		friction(ACC * delta)
	else:
		movement(vel * ACC * delta)
	
	motion = move_and_slide(motion)

func _process(_delta) -> void:
	scale.x = (global_position.y / get_viewport().size.y) * 1.75
	scale.y = scale.x
