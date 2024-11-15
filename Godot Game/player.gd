# appropriated from https://github.com/rbarongr/GodotFirstPersonController/blob/main/Player/player.gd

class_name Player extends Area3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sensitivity: float = 1.75

var mouse_captured: bool = false

var look_dir: Vector2 # Input direction for look/aim

var held_object: Area3D
var hands_free = true
signal stick_added

@onready var player: Area3D = $Player

func _ready() -> void:
	capture_mouse()

func _input(event):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		if(has_overlapping_areas()):
			process_left_click(get_overlapping_areas()[0])
		else:
			print("Nothing here to click on")
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT):
		if(has_overlapping_areas()):
			process_right_click(get_overlapping_areas()[0])
		else:
			print("Narrate surroundings")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_player()

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_player(sens_mod: float = 1.0) -> void:
	rotation.y -= look_dir.x * player_sensitivity * sens_mod

func process_left_click(area: Area3D):
	print(area.name)
	if(area.name.begins_with("Stick") && hands_free):
		held_object = area
		hands_free = false
		area.queue_free() #TODO: this is a problem if we ever want to see the stick again
		#TODO make it so that the stick stops existing but is stored somewhere, and then is placed wherever you put it down
		# This could be a thing for after Alpha fest, for now just need to put in fire (using hands_free variable)
	if(!hands_free):
		if(area.name.begins_with("Campfire")): # && held_object.name.begins_with("Stick")): > this doesn't work because
			#TODO: play whoosh and increase fire volume
			stick_added.emit()
			print("stick added")
			held_object = null
			hands_free = true

	
func process_right_click(area: Area3D):
	print("Narrate %s" % area.name)
