# appropriated from https://github.com/rbarongr/GodotFirstPersonController/blob/main/Player/player.gd

class_name Player extends CharacterBody3D

@export_range(0.1, 3.0, 0.1, "or_greater") var player_sens: float = 1

var mouse_captured: bool = false

var look_dir: Vector2 # Input direction for look/aim


@onready var player: CharacterBody3D = $Player

func _ready() -> void:
	capture_mouse()

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
	rotation.y -= look_dir.x * player_sens * sens_mod

