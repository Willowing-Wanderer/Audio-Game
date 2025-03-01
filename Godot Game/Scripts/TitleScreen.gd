extends ColorRect

@export var click_to_start:AkEvent3D

signal start_game

func _ready():
	await get_tree().create_timer(0.2).timeout
	click_to_start.post_event()

func _input(event):
	if (event.is_action_pressed("Interact")):
		get_parent().start_game()
		queue_free()
	
