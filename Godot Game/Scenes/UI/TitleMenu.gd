extends Node3D

var turn_info:AkEvent3D
var title:AkEvent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	turn_info = $Turn_Info
	title = $Title
	title.post_event()
	await get_tree().create_timer(3.5).timeout
	turn_info.post_event()
