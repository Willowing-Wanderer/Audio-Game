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
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	insect_cloud = $Insect_Cloud
	insect_cloud_narration = $Insect_Cloud_Narration
	insect_catch = $Insect_Catch
	insect_cloud.post_event()

func on_click(selected):
	if(selected == "Net"):
		player.set_cutscene(true)
		insect_catch.post_event()

func _on_insect_catch_end_of_event(data):
	player.add_to_inventory("Insect")
	player.set_cutscene(false)
