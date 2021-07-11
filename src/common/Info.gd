extends Node

# Get it out of the way PLS
var opening_out : bool = false
var it_goes : bool = false

# Who are we playing as?
enum {PLAYER_TREBLE = 0, PLAYER_CASEY = 1}
var chosen_player : int = -1

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
