extends KinematicBody2D

onready var rect = $rect

var FORCE : float = 200.0
var ACC : float = FORCE * 4.0

const ROT_SPEED : float = 128.0
const ROT_MAX : float = 360.0

var dir : Vector2 = Vector2.ZERO
var motion : Vector2 = Vector2.ZERO

func movement(val : Vector2) -> void:
	motion += val
	motion = motion.clamped(FORCE)

func _physics_process(delta) -> void:
	movement(dir * ACC * delta)
	motion = move_and_slide(motion)

func _process(delta):
	rect.rect_rotation = fposmod(rect.rect_rotation + (delta * ROT_SPEED), ROT_MAX)

func _on_area_body_entered(body):
	if body.name.find("enemy") != -1:
		body.enstun(global_position)
		queue_free()
	elif body.name == "lol":
		queue_free()
