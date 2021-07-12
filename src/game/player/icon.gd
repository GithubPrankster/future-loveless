extends Sprite

onready var anim = $anim
onready var health = $health

func ouchy(hp : int) -> void:
	anim.play("hurt")
	health.value = hp

func _ready():
	Info.connect("player_hurt", self, "ouchy")
