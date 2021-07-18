extends Node2D

const SCREEN_MIDDLE = Vector2(320.0, 180.0)

onready var playfield = $playfield
onready var ui = $ui

onready var ice = preload("res://src/game/magic/ice.tscn")
onready var fire = preload("res://src/game/magic/fire.tscn")

onready var bubble = preload("res://src/game/magic/bubble.tscn")
onready var homerun = preload("res://src/game/magic/homerun.tscn")

onready var control = $control
onready var anims = $anims

func _ready():
	Info.connect("magic_cast", self, "spawn_magic")
	Info.connect("the_end", self, "the_end")
	match(Info.chosen_player):
		Info.PLAYER_CASEY:
			var casey = load("res://src/game/player/casey/casey.tscn").instance()
			casey.global_position = SCREEN_MIDDLE
			var casey_icon = load("res://src/game/player/casey/casey_icon.tscn").instance()
			playfield.add_child(casey)
			ui.add_child(casey_icon)
			return
	var treble = load("res://src/game/player/treble/treble.tscn").instance()
	treble.global_position = SCREEN_MIDDLE
	var treble_icon = load("res://src/game/player/treble/treble_icon.tscn").instance()
	playfield.add_child(treble)
	ui.add_child(treble_icon)

func spawn_magic(magic_type, velocity, pos) -> void:
	var inst
	match(magic_type):
		Info.MAGIC_ICE:
			inst = ice.instance()
			inst.velocity = velocity
			Info.magic_used += 1
		Info.MAGIC_FIRE:
			inst = fire.instance()
			inst.velocity = velocity * 1.5
			if velocity.x < 0:
				inst.get_node("anim").flip_h = true
			Info.magic_used += 1
		Info.MAGIC_BUBBLES:
			inst = bubble.instance()
			inst.velocity = velocity * 0.1
			inst.global_position = pos
			playfield.add_child(inst)
			
			inst = bubble.instance()
			inst.velocity = velocity * -0.1
			inst.global_position = pos
			playfield.add_child(inst)
			Info.magic_used += 1
			return
		Info.MAGIC_BALL:
			inst = homerun.instance()
			inst.velocity = velocity * 6.0
			Info.magic_used += 1
		_:
			inst = ice.instance()
	inst.global_position = pos
	playfield.add_child(inst)

func the_end() -> void:
	control.queue_free()
	set_process(false)
	anims.play("fade-away")
	yield(anims, "animation_finished")
	SceneLoader.load_scene("res://src/credits/credits.tscn")
	
