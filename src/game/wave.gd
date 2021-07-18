extends Label

var counter : int = 1

export(Array, Vector2) var pos 

onready var prog = $wave_progress
onready var prog_text = $wave_progress/text

func progress() -> void:
	Info.emit_signal("the_end")

func _ready():
	Info.connect("enemy_ded", self, "decrement")

func decrement() -> void:
	counter -= 1
	prog.value = counter
	prog_text.text = str(counter) + " remains"
	if counter == 0:
		progress()
