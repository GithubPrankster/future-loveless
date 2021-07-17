extends Node

# Get it out of the way PLS
var opening_out : bool = false
var it_goes : bool = false

# Who are we playing as?
enum {PLAYER_TREBLE = 0, PLAYER_CASEY = 1}
var chosen_player : int = -1

var magic_used : int = 0
var health_lost : int = 0
var attack_done : int = 0

enum {MAGIC_ICE = 0, MAGIC_FIRE = 1, MAGIC_BUBBLES = 2, MAGIC_BALL = 3}

# Ouchy ouch
signal player_hurt(hp)
# Freeze!
signal mana_spent(mp)
# Ok so here's some ice
signal magic_cast(magic_type, velocity, pos)
# wow
signal new_health(hp)

# BAAACK IN TIMEEE
# TO ANOTHER WORLD
func reset_state():
	opening_out = false
	it_goes = false
	chosen_player = -1
	
	magic_used = 0
	health_lost = 0
	attack_done = 0

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
