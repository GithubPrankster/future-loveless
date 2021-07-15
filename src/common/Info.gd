extends Node

# Get it out of the way PLS
var opening_out : bool = false
var it_goes : bool = false

# Who are we playing as?
enum {PLAYER_TREBLE = 0, PLAYER_CASEY = 1}
var chosen_player : int = -1

enum {MAGIC_ICE = 0, MAGIC_FIRE = 1, MAGIC_BUBBLES = 2, MAGIC_BALL = 3}

# Ouchy ouch
signal player_hurt(hp)
# Ok so here's some ice
signal magic_cast(magic_type, velocity, pos)

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
