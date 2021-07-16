extends Sprite

onready var anim = $anim
onready var health = $health
onready var mana = $mana
onready var switch = $selectorama/anim

var switched : bool = false

func ouchy(hp : int) -> void:
	var diff : int = health.value - hp
	if diff > 0:
		anim.play("hurt")
	health.value = hp

func magic(mp : int) -> void:
	mana.value = mp

func _ready():
	Info.connect("player_hurt", self, "ouchy")
	Info.connect("mana_spent", self, "magic")

func _process(delta):
	if Input.is_action_just_pressed("switch"):
		switched = !switched
		if switched:
			switch.play("switch")
		else:
			switch.play_backwards("switch")
