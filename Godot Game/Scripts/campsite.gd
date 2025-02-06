extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	#print("???")
	if event.is_action_pressed("reload_game"): # && $ColorRect/Retry.visible:
		get_tree().reload_current_scene()


func _on_whoosh_fire_done():
	#$ColorRect/Retry.show()
	pass
