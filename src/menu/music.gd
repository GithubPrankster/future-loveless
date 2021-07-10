extends AudioStreamPlayer

func _process(delta):
	if volume_db != 0.0:
		volume_db = clamp(volume_db + (delta * 2.0), -80.0, 0.0)
