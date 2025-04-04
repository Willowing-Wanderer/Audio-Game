class_name Player extends Area3D

var hover_select:AkEvent3D
var hover_deselect:AkEvent3D
var pick_up:AkEvent3D
var interact:AkEvent3D
var pause_menu:AkEvent3D
var credits:AkEvent3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sensitivity: float = 1.0
var mouse_captured: bool = false
var look_dir: Vector2 # Input direction for look/aim

var in_title = true

var playing_id
var selected_max = 3
var facing_playing_id
var cutscene = false
var area_being_narrated:Area3D = null
var area_narration_playing = false
var completed_game = false

@onready var inventory = $Inventory
@onready var narrator = $Inventory_Narrator
@onready var player: Area3D = $Player

func _ready() -> void:
	pick_up = $Pick_up
	hover_select = $Hover_Select
	hover_deselect = $Hover_Deselect
	interact = $Interact
	pause_menu = $Pause_Menu
	credits = $Credits
	capture_mouse()

func _process(delta):
	var sensitivity = 0.03
	rotate_y(-Input.get_joy_axis(0,JOY_AXIS_RIGHT_X) * sensitivity)
		
	if(area_narration_playing):
		if(is_instance_valid(area_being_narrated)):
			area_narration_playing = area_being_narrated.playing_narration
		else:
			area_narration_playing = false
	var speed = 0.05
	if(Input.is_action_pressed("ui_left")):
		rotate_y(speed)
	if(Input.is_action_pressed("ui_right")):
		rotate_y(-speed)

# Process mouse inputs
func _input(event):
	
	# Left click
	if (event.is_action_pressed("Pause") && !in_title):
		pause_game()
	if (event.is_action_pressed("Interact")):
		if(has_overlapping_areas()):
			interact.post_event()
			process_left_click(get_overlapping_areas()[0])
			await get_tree().create_timer(0.2).timeout
		else:
			inventory.play_selected_sound()
	# Right click
	if (event.is_action_pressed("Narration")):
		if(area_narration_playing):
			area_being_narrated.stop_narration()
		else:
			if(narrator.playing_narration):
				narrator.stop_narration()
			else:
				if(has_overlapping_areas()):
					process_right_click(get_overlapping_areas()[0])
				else:
					narrator.narrate(inventory.get_selected())
	# Scroll
	if (event.is_action_pressed("Inventory_Up")):
		inventory.scroll_up()
	if (event.is_action_pressed("Inventory_Down")):
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
	area.on_click(inventory.get_selected())
	
func process_right_click(area: Area3D):
	area_being_narrated = area
	area_narration_playing = true
	area.narrate()

func add_to_inventory(item_name):
	pick_up.post_event()
	inventory.add_item(item_name)
	
func remove_from_inventory(item_name):
	inventory.remove_item(item_name)

func _on_area_entered(area):
	if(!cutscene):
		hover_select.post_event()

func _on_area_exited(area):
	if(!cutscene):
		hover_deselect.post_event()
		
func get_count(item_name):
	return inventory.get_count(item_name)

func set_cutscene(boolean):
	cutscene = boolean
	set_process_input(!boolean)
	if(boolean):
		if(area_narration_playing):
			area_being_narrated.stop_narration()
		else:
			if(narrator.playing_narration):
				narrator.stop_narration()

var game_paused = false
var last_position
var last_rotation

func pause_game():
	if (game_paused):
		position = last_position
		rotation = last_rotation
		game_paused = false
	else:
		if (completed_game):
			credits.post_event()
		else:
			pause_menu.post_event()
		last_position = position
		last_rotation = rotation
		position = Vector3(75,0,0)
		rotation = Vector3(0,0,0)
		game_paused = true
