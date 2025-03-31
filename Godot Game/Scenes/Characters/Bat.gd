extends Area3D

var bat_bumping:AkEvent3D
var bat_dialog:AkEvent3D
var bat_thanks:AkEvent3D
var bat_narration:AkEvent3D

signal cave_unlocked

# Needed if you want to do anything with the player's controls
var player:Node3D

signal quest_complete

var first_click = true

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	bat_narration.post_event()

func _on_narrate_druid_end_of_event(data):
	playing_narration = false
	
func stop_narration():
	playing_narration = false
	bat_narration.stop_event()
	
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	bat_bumping = $Bat_Bumping
	bat_dialog = $Bat_Dialog
	bat_thanks = $Bat_Thanks
	bat_bumping.post_event()

func on_click(selected):
	bat_bumping.stop_event()
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout

	if(selected == "Insect"):
		player.remove_from_inventory("Mushroom")
		cave_unlocked.emit()
		bat_thanks.post_event()
	else:
		bat_dialog.post_event()
