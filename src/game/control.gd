extends Node2D

onready var anim = $letsgo

onready var de_anim = $"../anims"

onready var pause = $pause_menu

onready var gameover = $game_over

func _ready():
	Info.connect("game_over", self, "sorry")

func _process(delta):
	if !de_anim.is_playing():
		if Input.is_action_just_pressed("pause") and !gameover.visible:
			get_tree().paused = !get_tree().paused
			pause.visible = !pause.visible
		if pause.visible:
			pause.nice_thing()
		if (pause.visible or gameover.visible) and Input.is_action_just_pressed("switch"):
			anim.play("enclosure")
			yield(anim,"animation_finished")
			SceneLoader.load_scene("res://src/menu/menu.tscn")
			set_process(false)

func sorry():
	get_tree().paused = true
	gameover.visible = true
	anim.play("gameovered")
