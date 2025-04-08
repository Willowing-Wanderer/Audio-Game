extends Area3D

@export var circle:Node3D
var player:Node3D
@export var path_sound:AkEvent3D
@export var path_narration:AkEvent3D
@export var footsteps:AkEvent3D

var object_name = "Path"
const SPEED = 3
var destination = null
var walking = false
var playing_narration = false

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")

func _process(delta):
	if(walking):
		player.position += player.position.direction_to(destination) * SPEED * delta

func narrate():
	playing_narration = true
	path_narration.post_event()

func on_click(selected):
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

func _on_path_northeast_narration_end_of_event(data):
	playing_narration = false

func _on_path_southwest_narration_end_of_event(data):
	playing_narration = false

func _on_path_southeast_narration_end_of_event(data):
	playing_narration = false

func _on_path_northwest_narration_end_of_event(data):
	playing_narration = false

func _on_path_south_narration_end_of_event(data):
	playing_narration = false

func _on_path_north_narration_end_of_event(data):
	playing_narration = false

func _on_path_east_narration_end_of_event(data):
	playing_narration = false

func _on_path_west_narration_end_of_event(data):
	playing_narration = false
