extends Node2D

onready var anim = $anims
onready var kid_anim = $kids/anim
var opening_out : bool = false

func _input(_event) -> void:
	if Input.is_action_just_pressed("accept") and !opening_out and !anim.is_playing():
		opening_out = true
		anim.play("fade-opening")
		kid_anim.play("move-in")
		Info.opening_out = true
