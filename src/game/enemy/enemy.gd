extends KinematicBody2D

onready var stunny = $stun_timer
onready var spr = $spr

export(int) var health : int = 9

export(float) var FORCE : float = 50.0
var ACC : float = FORCE * 4.0

const MAX_COMBO : int = 2

const HIT_COL : Color = Color(0.0, 0.5, 0.5, 1.0)
const FREEZE_COL : Color = Color(0.0, 0.5, 0.8, 1.0)
const NORM_COL : Color = Color(0xFF0505FF)

var player = null
var motion : Vector2 = Vector2.ZERO
var stunned : bool = false
var comboed : int = MAX_COMBO

func axis() -> Vector2:
	if player and !stunned:
		return (player.position - position).normalized()
	return Vector2.ZERO

func friction(val : float) -> void:
	if motion.length() > val:
		motion -= motion.normalized() * val
	else:
		motion = Vector2.ZERO

func movement(val : Vector2) -> void:
	motion += val
	motion = motion.clamped(FORCE)

func _physics_process(delta) -> void:
	var vel : Vector2 = axis()
	if vel == Vector2.ZERO:
		friction(ACC * delta)
	else:
		movement(vel * ACC * delta)
	
	motion = move_and_slide(motion)

func _on_area_body_entered(body):
	if body.name == "player":
		player = body

func hurty(pos : Vector2, dmg : int, col : Color):
	if health > 0 and comboed != 0:
		health -= dmg
		
		var hit_dir : Vector2 = -(pos - global_position).normalized()
		
		motion = move_and_slide(hit_dir * (ACC / 2.0))
		
		if stunned:
			comboed -= 1
			
		spr.color = col
		stunned = true
		stunny.start()

func _on_hurtbox_area_entered(area):
	if area.name == "atk":
		hurty(area.global_position, 1, HIT_COL)

func enstun(pos : Vector2) -> void:
	hurty(pos, 2, FREEZE_COL)

func _on_stun_timer_timeout():
	if health <= 0:
		queue_free()
	
	stunned = false
	comboed = MAX_COMBO
	spr.color = NORM_COL
