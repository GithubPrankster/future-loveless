extends Node2D

onready var opening = $opening
var opening_out : bool = false

func _ready() -> void:
	modulate.v = 0.0

func _process(delta):
	if Input.is_action_just_pressed("accept") and !opening_out:
		opening_out = true
	
	if opening_out and opening.modulate.a != 0.0:
		opening.modulate.a = clamp(opening.modulate.a - (delta * 2.5), 0.0, 1.0)
	
	if modulate.v != 1.0:
			modulate.v = clamp(modulate.v + (delta * 0.5), 0.0, 1.0)
