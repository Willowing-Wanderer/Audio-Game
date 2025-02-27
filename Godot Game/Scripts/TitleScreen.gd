extends ColorRect

@export var click_to_start:AkEvent3D

signal start_game

func _ready():
	#pass
	click_to_start.post_event()

func _input(event):
	if(event is InputEventMouseButton):
		# Left click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			get_parent().start_game()
			queue_free()
