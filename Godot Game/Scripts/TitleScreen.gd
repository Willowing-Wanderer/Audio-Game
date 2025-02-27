extends ColorRect


func _input(event):
	if(event is InputEventMouseButton):
		# Left click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			pass
