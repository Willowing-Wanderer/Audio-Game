extends Area3D

@export var circle:Node3D
var player:Node3D
@export var path_sound:AkEvent3D
@export var path_narration:AkEvent3D
@export var footsteps:AkEvent3D

signal path_locked

var object_name = "Path"
const SPEED = 3
var destination = null
var walking = false
var playing_narration = false
var locked = true

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")

func _process(delta):
	if(walking):
		player.position += player.position.direction_to(destination) * SPEED * delta

func narrate():
	playing_narration = true
	path_narration.post_event()

func on_click(selected):
	if(locked):
		path_locked.emit()
	else:
		player.set_cutscene(true)
		footsteps.post_event()
		destination = circle.position
		walking = true
	
func stop_narration():
	playing_narration = false
	path_narration.stop_event()

func _on_footsteps_end_of_event(data):
	player.position = destination
	walking = false
	destination = null
	player.set_cutscene(false)

func _on_bat_you_path_unlocked():
	locked = false
