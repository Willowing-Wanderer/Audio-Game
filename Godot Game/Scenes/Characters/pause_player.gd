class_name PausePlayer extends Area3D

var hover_select:AkEvent3D
var hover_deselect:AkEvent3D
var interact:AkEvent3D
var click_fail:AkEvent3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sensitivity: float = 1.0
var mouse_captured: bool = false
var look_dir: Vector2 # Input direction for look/aim

func _ready() -> void:
	hover_select = $Hover_Select
	hover_deselect = $Hover_Deselect
	interact = $Interact
	capture_mouse()

func _process(delta):
	var sensitivity = 0.03
	rotate_y(-Input.get_joy_axis(0,JOY_AXIS_RIGHT_X) * sensitivity)
		
	var speed = 0.05
	if(Input.is_action_pressed("ui_left")):
		rotate_y(speed)
	if(Input.is_action_pressed("ui_right")):
		rotate_y(-speed)

# Process mouse inputs
func _input(event):
	# Left click
	if (event.is_action_pressed("Pause")):
		print("unpause?")
		get_tree().paused = false
	if (event.is_action_pressed("Interact")):
		if(has_overlapping_areas()):
			interact.post_event()
			process_left_click(get_overlapping_areas()[0])
			await get_tree().create_timer(0.2).timeout
		else:
			click_fail.post_event()


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
	area.on_click("none")

func _on_area_entered(area):
	hover_select.post_event()

func _on_area_exited(area):
	hover_deselect.post_event()
		
