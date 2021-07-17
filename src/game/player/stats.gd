extends Node

export(int) var health : int = 16 setget spent_health
onready var max_health : int = health

export(int) var mana : int = 4 setget spend_mana
onready var max_mana: int = mana

enum AttackType {DEFAULT = 0, ICE = 1, FIRE = 2, BUBBLE = 3, BALL = 4}
export(Array, AttackType) var powers = [AttackType.ICE, AttackType.FIRE]

func spent_health(hp):
	health = hp
	Info.emit_signal("player_hurt", hp)

func spend_mana(val):
	mana = val
	Info.emit_signal("mana_spent", val)
