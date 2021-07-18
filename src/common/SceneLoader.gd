extends Node

var load_screen : PackedScene = preload("res://src/common/load.tscn")

var root = null
var current_scene = null

var loader : ResourceInteractiveLoader = null
const TIME_MAX = 100 # msec

func _ready() -> void:
	root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func _scene_switcher(res : PackedScene) -> void:
	var new_one = res.instance()
	root.add_child(new_one)
	
	current_scene.queue_free()
	current_scene = new_one

func _process(_delta) -> void:
	if loader == null:
		set_process(false)
		return

	while OS.get_ticks_msec() < OS.get_ticks_msec() + TIME_MAX:
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finish!
			_scene_switcher(loader.get_resource())
			loader = null
			break
		elif err != OK:
			print("WOW. Couldn't even load it?!")
			loader = null
			break

func load_scene(path : String) -> void:
	loader = ResourceLoader.load_interactive(path)
	set_process(true)
	
	_scene_switcher(load_screen)
	get_tree().paused = false
