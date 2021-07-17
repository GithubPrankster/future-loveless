extends Node2D

onready var playfield = $playfield

onready var ice = preload("res://src/game/magic/ice.tscn")
onready var fire = preload("res://src/game/magic/fire.tscn")

onready var bubble = preload("res://src/game/magic/bubble.tscn")
onready var homerun = preload("res://src/game/magic/bubble.tscn")

func _ready():
	Info.connect("magic_cast", self, "spawn_magic")

func spawn_magic(magic_type, velocity, pos) -> void:
	var inst
	match(magic_type):
		Info.MAGIC_ICE:
			inst = ice.instance()
			inst.velocity = velocity
		Info.MAGIC_FIRE:
			inst = fire.instance()
			inst.velocity = velocity * 1.5
		Info.MAGIC_BUBBLES:
			inst = bubble.instance()
			inst.velocity = velocity * 0.3
			inst.global_position = pos
			playfield.add_child(inst)
			
			inst = bubble.instance()
			inst.velocity = velocity * -0.3
			inst.global_position = pos
			playfield.add_child(inst)
			return
		Info.MAGIC_BALL:
			inst = homerun.instance()
			inst.velocity = velocity * 3.0
		_:
			inst = ice.instance()
	inst.global_position = pos
	playfield.add_child(inst)
