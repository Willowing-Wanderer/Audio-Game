extends Area3D

var environmental:AkEvent3D
var narrate_environmental:AkEvent3D
var player:Node3D
var playing_narration = false

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
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
	player.pause_game()

func _on_narrate_environmental_end_of_event(data):
	playing_narration = false

func _on_area_entered(area):
	if(!player.cutscene):
		await get_tree().create_timer(0.1).timeout
		narrate_environmental.post_event()
