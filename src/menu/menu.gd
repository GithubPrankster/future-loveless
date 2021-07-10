extends Node2D

onready var anim = $anims
var opening_out : bool = false

func _process(delta):
	if Input.is_action_just_pressed("accept") and !opening_out:
		opening_out = true
		anim.play("fade-opening")
