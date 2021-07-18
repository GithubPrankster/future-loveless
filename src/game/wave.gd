extends Label

var counter : int = 4

export(Array, Vector2) var pos 

onready var prog = $wave_progress
onready var prog_text = $wave_progress/text

func progress() -> void:
	counter = 4
	yield()
	Info.emit_signal("the_end")

func _ready():
	Info.connect("enemy_ded", self, "decrement")

func decrement() -> void:
	counter -= 1
	prog.value = counter
	prog_text.text = str(counter) + " remain"
	if counter == 0:
		progress()
