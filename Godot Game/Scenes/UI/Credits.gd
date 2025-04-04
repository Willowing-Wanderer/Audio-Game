extends Node3D

var credits:AkEvent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	credits = $Credits
	credits.post_event()
