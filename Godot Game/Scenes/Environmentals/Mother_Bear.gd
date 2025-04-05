extends Area3D

var environmental:AkEvent3D
var bear_pacing:AkEvent3D
var bear_narration_1:AkEvent3D
var bear_dialog:AkEvent3D
var bear_thanks:AkEvent3D
var bears_playing:AkEvent3D
var bear_narration_2:AkEvent3D

var playing_narration = false
var reunited = false

var player:Node3D

signal cave_unlocked

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	bear_pacing = $Bear_Pacing
	bear_narration_1 = $Bear_Narration_1
	bear_dialog = $Bear_Dialog
	bear_thanks = $Bear_Thanks
	bears_playing = $Bears_Playing
	bear_narration_2 = $Bear_Narration_2
	bear_pacing.post_event()

func narrate():
	if (reunited):
		bear_narration_2.post_event()
	else:
		bear_narration_1.post_event()
	playing_narration = true

func stop_narration():
	bear_narration_1.stop_event()
	bear_narration_2.stop_event()
	playing_narration = false

func on_click(selected):
	bear_pacing.stop_event()
	player.set_cutscene(true)
	if(reunited || player.has_bears == true):
		if(player.has_bears):
			rotate_y(5.0)
		bear_thanks.post_event()
		player.has_bears = false
		reunited = true
		cave_unlocked.emit()
	else:
		bear_dialog.post_event()

func _on_bear_narration_1_end_of_event(data):
	playing_narration = false

func _on_bear_narration_2_end_of_event(data):
	playing_narration = false

func _on_bear_dialog_end_of_event(data):
	player.set_cutscene(false)
	bear_pacing.post_event()

func _on_bear_thanks_end_of_event(data):
	player.set_cutscene(false)
	bears_playing.post_event()
