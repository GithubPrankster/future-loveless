extends Sprite

onready var anim = $anim

func ouchy(hp : int) -> void:
	anim.play("hurt")
	# TODO: Health bar shenanigans

func _ready():
	Info.connect("player_hurt", self, "ouchy")
