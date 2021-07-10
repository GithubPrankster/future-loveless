extends Node2D

onready var treble_anim = $treble/anim
onready var casey_anim = $casey/anim

func _process(_delta) -> void:
	if Info.opening_out and !casey_anim.is_playing() and !treble_anim.is_playing():
		if Input.is_action_just_pressed("left") and $treble.modulate.a != 1.0:
			treble_anim.play("hover")
			if $casey.modulate.a == 1.0:
				casey_anim.play("unhover")
		if Input.is_action_just_pressed("right") and $casey.modulate.a != 1.0:
			if $treble.modulate.a == 1.0:
				treble_anim.play("unhover")
			casey_anim.play("hover")
