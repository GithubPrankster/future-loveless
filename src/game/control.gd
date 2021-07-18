extends Node2D

onready var anim = $letsgo

onready var de_anim = $"../anims"

onready var pause = $pause_menu

func _process(delta):
	if !de_anim.is_playing():
		if Input.is_action_just_pressed("pause"):
			get_tree().paused = !get_tree().paused
			pause.visible = !pause.visible
		if pause.visible:
			pause.nice_thing()
			if Input.is_action_just_pressed("switch"):
				anim.play("enclosure")
				yield(anim,"animation_finished")
				SceneLoader.load_scene("res://src/menu/menu.tscn")
				set_process(false)
