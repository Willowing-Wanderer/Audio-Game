extends Node3D

var turn_info:AkEvent3D
var title:AkEvent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_info = $Turn_Info
	title = $Title
	turn_info.post_event()

func _on_title_end_of_event(data):
	turn_info.post_event()
