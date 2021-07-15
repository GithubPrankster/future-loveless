extends Node2D

onready var playfield = $playfield

onready var ice = preload("res://src/game/magic/ice.tscn")

func _ready():
	Info.connect("magic_cast", self, "spawn_magic")

func spawn_magic(magic_type, velocity, pos) -> void:
	var inst
	match(magic_type):
		Info.MAGIC_ICE:
			inst = ice.instance()
		_:
			inst = ice.instance()
	inst.velocity = velocity
	inst.global_position = pos
	playfield.add_child(inst)
