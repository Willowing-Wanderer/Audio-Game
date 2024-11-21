# appropriated from https://github.com/rbarongr/GodotFirstPersonController/blob/main/Player/player.gd

class_name Player extends Area3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sensitivity: float = 1.75

var mouse_captured: bool = false

var look_dir: Vector2 # Input direction for look/aim

var held_object: Area3D
var hands_free = true
signal stick_added

var playing_id
var level = "tinder"
var sticks_to_next_level = 2

@onready var player: Area3D = $Player

func _ready() -> void:
	capture_mouse()

func _input(event):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		if(has_overlapping_areas()):
			process_left_click(get_overlapping_areas()[0])
		#else:
			#print("Nothing here to click on")
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT):
		if(has_overlapping_areas()):
			process_right_click(get_overlapping_areas()[0])
		else:
			#print("Narrate Nothing")
			if(playing_id):
				Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
			Wwise.register_game_obj(self, self.get_name())
			Wwise.set_3d_position(self, get_global_transform())
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_NOTHING, self)

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
	
func increase_level():
	if(level == "tinder"):
		sticks_to_next_level = 2
		level = "kindling"
	else:
		if(level == "kindling"):
			level = "fuel"
			sticks_to_next_level = 2
		else:
			if(level == "fuel"):
				level = "done"

func process_left_click(area: Area3D):
	#print(area.name)
	if(hands_free &&
		(area.name.begins_with("Tinder") && level == "tinder" ||
		area.name.begins_with("Kindling") && level == "kindling" ||
		area.name.begins_with("Fuel") && level == "fuel")
		):
		held_object = area
		hands_free = false
		area.queue_free() #TODO: this is a problem if we ever want to see the stick again
		#TODO make it so that the stick stops existing but is stored somewhere, and then is placed wherever you put it down
		# This could be a thing for after Alpha fest, for now just need to put in fire (using hands_free variable)
	if(!hands_free):
		if(area.name.begins_with("Campfire")): # && held_object.name.begins_with("Stick")): > this doesn't work because
			stick_added.emit()
			#print("level")
			#print(level)
			#print("stick added")
			sticks_to_next_level -= 1
			if(sticks_to_next_level == 0):
				increase_level()
			held_object = null
			hands_free = true

	
func process_right_click(area: Area3D):
	#print("Narrate %s" % area.name)
	if(playing_id):
		Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	
	if(area.name.begins_with("Tinder")):
		playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_TINDER, self)
	if(area.name.begins_with("Kindling")):
		if(level == "kindling"):
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_KINDLING, self)
		else:
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_TOOLARGE, self)
	if(area.name.begins_with("Fuel")):
		if(level == "fuel"):
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_FUEL, self)
		else:
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_TOOLARGE, self)
	if(area.name.begins_with("Campfire")):
		if(level == "tinder"):
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_DYINGFIRE, self)
		if(level == "kindling"):
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_SMALLFLAME, self)
		if(level == "fuel"):
			playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_HUNGRYFIRE, self)
		
