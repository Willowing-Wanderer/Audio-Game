extends Area3D

var environmental:AkEvent3D
var narrate_environmental:AkEvent3D
var cubs_eating:AkEvent3D
var cubs_dialog:AkEvent3D
var cubs_footsteps:AkEvent3D

var playing_narration = false
var player:Node3D

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	environmental = $EnvironmentalEvent
	narrate_environmental = $Cubs_Narration
	cubs_eating = $Cubs_Eating
	cubs_dialog = $Cubs_Dialog
	cubs_eating.post_event()

func narrate():
	narrate_environmental.post_event()
	playing_narration = true

func stop_narration():
	narrate_environmental.stop_event()
	playing_narration = false

func on_click(selected):
	cubs_eating.stop_event()
	player.set_cutscene(true)
	cubs_dialog.post_event()

func _on_narrate_environmental_end_of_event(data):
	playing_narration = false

func _on_cubs_dialog_end_of_event(data):
	player.has_bears = true
	player.set_cutscene(false)
	queue_free()
