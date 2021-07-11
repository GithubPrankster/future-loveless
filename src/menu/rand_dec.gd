extends Label

var cnt : bool = false
var pick : int = 0
const epic_text = [
	["Passed all the competition man,\n","ninjamuffin is next"],
	["I stayed up all night\n","to write this stupid text"],
	["It's gonna be legen\n","dary"],
	["Setup\n","Punchline"],
	["Sneed's Feed and Seed\n","::formerly Chucks::"],
	["Ram Ranch\n", "it rocks"],
	["Sandvich\n","make me strong"],
	["This world has been\n","connected."],
	["With future pixels\n","in factories far away"],
	["Pumping iron\n","for 3 days straight"],
	["NFT\n","No Fucking Thanks!"],
	["dis game sux\n","the grafx are ps2"],
	["The Dark Souls\n","of beat em ups"],
	["My life\n","is liek a bideo game"],
	["Play it\n","loud"],
	["Hes a big fan\nof the internet\n","Leaving lots of comments\nthat you wont forget"],
	["My friends\n","are my power!"],
	["No dick jokes\n","just doesnt fit yknow"],
	["UN Owen\n","wasnt her"],
	["J00 guna luv dis ga3m\n","it haz b1g p3nor i thnk"],
	["Its the\n","nutshack"],
	["Death Ray\n","Golden Age"],
	["No pacman!\n","Drugs are baaad!"],
	["Are we the last\n", "living souls"],
	["Cmon Gavin Newsome\n","Take it like a man"]
]

func epic_label() -> void:
	text = epic_text[pick][0]
	if cnt:
		text += epic_text[pick][1]
	else:
		cnt = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pick = randi() % len(epic_text)
