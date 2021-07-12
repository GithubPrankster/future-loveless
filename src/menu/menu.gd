extends Node2D

onready var anim = $anims
onready var kid_anim = $kids/anim

var opening_out : bool = false

func _process(_delta) -> void:
	if !anim.is_playing():
		if Input.is_action_just_pressed("accept"):
			if !opening_out:
				opening_out = true
				anim.play("fade-opening")
				kid_anim.play("move-in")
				Info.opening_out = true
			elif opening_out and Info.chosen_player != -1:
				Info.it_goes = true
				anim.play("fade-out")
				yield(anim, "animation_finished")
				SceneLoader.load_scene("res://src/game/world.tscn")
				set_process(false)
