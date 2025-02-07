# appropriated from https://github.com/rbarongr/GodotFirstPersonController/blob/main/Player/player.gd

class_name Player extends Area3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sensitivity: float = 1.0

var mouse_captured: bool = false

var look_dir: Vector2 # Input direction for look/aim

var held_object: Area3D
var hands_free = true
signal stick_added

var playing_id
var level = "tinder"
var sticks_to_next_level = 2

var selected = 3 # empty by default
var selected_max = 3

@onready var hotbar = $Hotbar

@onready var player: Area3D = $Player

func _ready() -> void:
	capture_mouse()

# Process mouse inputs
func _input(event):
	if(event is InputEventMouseButton):
		# Left click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			if(has_overlapping_areas()):
				process_left_click(get_overlapping_areas()[0])
			else:
				# TODO: Make selcted item sound
				print(selected)
				Wwise.register_game_obj(self, self.get_name())
				Wwise.set_3d_position(self, get_global_transform())
				playing_id = Wwise.post_event_id(AK.EVENTS.CLICK_FAIL, self)
		# Right click
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
		# Scroll
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_WHEEL_UP):
			if(selected == selected_max):
				selected = 0
			else:
				selected += 1
			hotbar.select(selected)
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			if(selected == 0):
				selected = selected_max
			else:
				selected -= 1
			hotbar.select(selected)

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
	if(area.name.begins_with("Item")) || area.name.begins_with("Path"):
		# pass the selected item into the environmental
		area.on_click()
	else:
		if(area.name.begins_with("Environmental")):
			area.interact(selected)
		else:
			Wwise.register_game_obj(self, self.get_name())
			Wwise.set_3d_position(self, get_global_transform())
			playing_id = Wwise.post_event_id(AK.EVENTS.CLICK_FAIL, self)
 


	
func process_right_click(area: Area3D):
	#print("Narrate %s" % area.name)
	if(playing_id):
		Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	
	#if(area.name.begins_with("Tinder")):
		#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_TINDER, self)
	#if(area.name.begins_with("Kindling")):
		#if(level == "kindling"):
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_KINDLING, self)
		#else:
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_TOOLARGE, self)
	#if(area.name.begins_with("Fuel")):
		#if(level == "fuel"):
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_FUEL, self)
		#else:
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_TOOLARGE, self)
	#if(area.name.begins_with("Campfire")):
		#if(level == "tinder"):
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_DYINGFIRE, self)
		#if(level == "kindling"):
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_SMALLFLAME, self)
		#if(level == "fuel"):
			#playing_id = Wwise.post_event_id(AK.EVENTS.NARRATE_HUNGRYFIRE, self)
		
