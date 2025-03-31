extends Area3D

var insect_cloud:AkEvent3D
var insect_cloud_narration:AkEvent3D
var insect_catch:AkEvent3D

# Needed if you want to do anything with the player's controls
var player:Node3D

signal quest_complete

var first_click = true

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	insect_cloud_narration.post_event()

func _on_narrate_druid_end_of_event(data):
	playing_narration = false
	
func stop_narration():
	playing_narration = false
	insect_cloud_narration.stop_event()
	
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	insect_cloud = $Insect_Cloud
	insect_cloud_narration = $Insect_Cloud_Narration
	insect_catch = $Insect_Catch
	insect_cloud.post_event()

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	await get_tree().create_timer(1).timeout
	
	if(selected == "Net"):
		player.set_cutscene(true)
		insect_catch.post_event()

func _on_insect_catch_end_of_event(data):
	print("huh?")
	Wwise.post_event_id(AK.EVENTS.PICK_UP, self)
	player.add_to_inventory("Insect")
	player.set_cutscene(false)
