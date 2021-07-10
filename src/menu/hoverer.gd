extends Sprite

onready var anim = $anim
onready var adios = $audio
export(bool) var but_who_first = false

var lf : String = "left"
var rf : String = "right"

func _ready() -> void:
	if but_who_first:
		var temp : String = lf
		lf = rf
		rf = temp

# TODO: This is atrocious and does not handle multi-press please kill it
#genious.
func _input(_event) -> void:
	if Info.opening_out:
		if Input.is_action_just_pressed(lf) and modulate.a != 1.0:
			anim.play("hover")
			adios.play()
		elif Input.is_action_just_pressed(rf) and modulate.a == 1.0:
			anim.play_backwards("hover")
