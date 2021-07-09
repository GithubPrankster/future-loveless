extends KinematicBody2D

onready var atk_box = $atk/attack
onready var ice_time = $ice_timer
onready var icey = preload("res://src/game/magic/ice.tscn")

export(float) var FORCE  = 160.0
var ACC : float = FORCE * 4.0

var velocity : Vector2 = Vector2.ZERO
var last_vel : Vector2 = Vector2.ZERO
var motion : Vector2 = Vector2.ZERO

var root = null

var ice_cast : bool = false

func _ready() -> void:
	root = get_tree().get_root()

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
		last_vel = axis()
		movement(vel * ACC * delta)
	
	if vel.x > 0.0:
		atk_box.position.x = 46.0
	elif vel.x < 0.0:
		atk_box.position.x = -46.0
	
	motion = move_and_slide(motion)
	
	if Input.is_action_just_pressed("attack"):
		atk_box.disabled = false
	else:
		atk_box.disabled = true
	
	if Input.is_action_just_pressed("cast") and !ice_cast:
		var proj = icey.instance()
		proj.global_position = global_position
		proj.dir = last_vel
		root.add_child(proj)
		
		ice_cast = true
		ice_time.start()

func _on_ice_timer_timeout():
	ice_cast = false
