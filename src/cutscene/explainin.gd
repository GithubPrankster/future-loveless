extends Node2D

onready var pos = $pos
onready var anim = $anim

# Called when the node enters the scene tree for the first time.
func _ready():
	match(Info.chosen_player):
		Info.PLAYER_CASEY:
			pos.add_child(load("res://src/cutscene/casey-story.tscn").instance())
			return
	pos.add_child(load("res://src/cutscene/treble-story.tscn").instance())

func _process(delta):
	if Input.is_action_just_pressed("accept"):
		var thingy = pos.get_node("story").frame + 1
		if thingy > 5:
			anim.play_backwards("fade-in")
			yield(anim,"animation_finished")
			SceneLoader.load_scene("res://src/game/world.tscn")
			set_process(false)
		else:
			pos.get_node("story").frame = thingy
