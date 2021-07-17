extends Node2D

onready var stats = $stats
onready var anim = $anims

# Called when the node enters the scene tree for the first time.
func _ready():
	var mu : String = str(Info.magic_used)
	var hl : String = str(Info.health_lost)
	var ad : String = str(Info.attack_done)
	stats.text = "Magic used: " + mu + "\nHealth lost: " + hl + " hp\nAttacks done: " + ad

func _process(delta):
	if Input.is_action_just_pressed("pause") and !anim.is_playing():
		anim.play_backwards("fade-in")
		yield(anim, "animation_finished")
		Info.reset_state()
		SceneLoader.load_scene("res://src/menu/menu.tscn")
		set_process(false)
