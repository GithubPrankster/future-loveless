extends Control

var selected : int = 0

onready var mainvol = $main_vol
onready var musicvol = $music_vol
onready var sfxvol = $sfx_vol

onready var anim = $anim
var active : bool = false

func _ready():
	mainvol.value = db2linear(AudioServer.get_bus_volume_db(0))
	musicvol.value = db2linear(AudioServer.get_bus_volume_db(1))
	sfxvol.value = db2linear(AudioServer.get_bus_volume_db(2))
	set_process(false)

func nice_thing() -> void:
	var vert : int = 0
	if Input.is_action_just_pressed("up"):
		vert = -1
	if Input.is_action_just_pressed("down"):
		vert = 1
	
	if vert != 0:
		if selected + vert < 0:
			selected = 2
		elif selected + vert > 2:
			selected = 0
		else:
			selected += vert
			
		mainvol.modulate = Color(1,1,1,1)
		musicvol.modulate = Color(1,1,1,1)
		sfxvol.modulate = Color(1,1,1,1)
		match(selected):
			0:
				anim.play("select_main")
			1:
				anim.play("select_music")
			2:
				anim.play("select_sfx")
	
	var horz : int = 0
	if Input.is_action_just_pressed("left"):
		horz = -1
	if Input.is_action_just_pressed("right"):
		horz = 1
	
	if horz != 0:
		match(selected):
			0:
				mainvol.value += mainvol.step * horz
			1:
				musicvol.value += musicvol.step * horz
			2:
				sfxvol.value += sfxvol.step * horz

func main_vol_change(value):
	AudioServer.set_bus_volume_db(0, linear2db(value))

func music_vol_change(value):
	AudioServer.set_bus_volume_db(1, linear2db(value))

func sfx_vol_change(value):
	AudioServer.set_bus_volume_db(2, linear2db(value))
