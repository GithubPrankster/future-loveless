extends Area2D

var player = null

func is_player_active() -> bool:
	return player != null

func body_entered(body):
	if body.name == "player":
		player = body
		print(body)
