extends Node2D

onready var stats = $stats

# Called when the node enters the scene tree for the first time.
func _ready():
	var mu : String = str(Info.magic_used)
	var hl : String = str(Info.health_lost)
	var ad : String = str(Info.attack_done)
	stats.text = "Magic used: " + mu + "\nHealth lost: " + hl + " hp\nAttacks done: " + ad
