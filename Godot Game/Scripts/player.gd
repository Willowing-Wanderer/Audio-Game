# appropriated from https://github.com/rbarongr/GodotFirstPersonController/blob/main/Player/player.gd

class_name Player extends Area3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sensitivity: float = 1.0

var mouse_captured: bool = false

var look_dir: Vector2 # Input direction for look/aim

var held_object: Area3D
var hands_free = true

var playing_id

var selected = 3 # empty by default
var selected_max = 3

var facing_playing_id

@onready var inventory = $Inventory
@onready var narrator = $Narrator

@onready var player: Area3D = $Player

func _ready() -> void:
	capture_mouse()
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())

# Process mouse inputs
func _input(event):
	if(event is InputEventMouseButton):
		# Left click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			if(has_overlapping_areas()):
				process_left_click(get_overlapping_areas()[0])
			else:
				inventory.play_selected_sound()
		# Right click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT):
			if(has_overlapping_areas()):
				process_right_click(get_overlapping_areas()[0])
			else:
				narrator.narrate(inventory.get_selected())
		# Scroll
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_WHEEL_UP):
			inventory.scroll_up()
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			inventory.scroll_down()

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
	area.on_click(selected)
 
	
func process_right_click(area: Area3D):
	narrator.narrate(area.object_name)

func add_to_inventory(item_name):
	inventory.add_item(item_name)

func _on_area_entered(area):
	if(facing_playing_id):
		Wwise.stop_event(facing_playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	facing_playing_id = Wwise.post_event_id(AK.EVENTS.FACING, self)

func _on_area_exited(area):
	if(facing_playing_id):
		Wwise.stop_event(facing_playing_id, 500, AkUtils.AK_CURVE_LINEAR)
		

