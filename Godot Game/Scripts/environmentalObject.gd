extends Area3D

var environmental:AkEvent3D
var narrate_environmental:AkEvent3D

var playing_narration = false

func _ready():
	environmental = $EnvironmentalEvent
	narrate_environmental = $Narrate_Environmental
	environmental.post_event()

func narrate():
	narrate_environmental.post_event()
	playing_narration = true

func stop_narration():
	narrate_environmental.stop_event()
	playing_narration = false

func on_click(selected):
	pass

func _on_narrate_environmental_end_of_event(data):
	playing_narration = false
