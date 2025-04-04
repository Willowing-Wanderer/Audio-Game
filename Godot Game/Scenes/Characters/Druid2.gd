extends Area3D

var druid_hum:AkEvent3D
var druid_help:AkEvent3D
var druid_thanks:AkEvent3D
var druid_restoration:AkEvent3D
var narrate_druid:AkEvent3D

# Needed if you want to do anything with the player's controls
var player:Node3D

signal quest_complete

var first_click = true

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	narrate_druid.post_event()

func _on_narrate_druid_end_of_event(data):
	playing_narration = false
	
func stop_narration():
	playing_narration = false
	narrate_druid.stop_event()
	
func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	druid_hum = $Druid_Hum
	druid_help = $Druid_Help_2
	druid_thanks = $Druid_Thanks_2
	druid_restoration = $Druid_Restoration
	narrate_druid = $Narrate_Druid
	druid_hum.post_event()

func on_click(selected):
	druid_hum.stop_event()
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout
	
	if(selected == "Crystal"):
		player.remove_from_inventory("Crystal")
		druid_thanks.post_event()
	else:
		druid_help.post_event()

func _on_druid_thanks_2_end_of_event(data):
	druid_restoration.post_event()

func _on_druid_restoration_end_of_event(data):
	await get_tree().create_timer(5).timeout
	player.set_cutscene(false)
	quest_complete.emit()

func _on_druid_help_2_end_of_event(data):
	player.set_cutscene(false)
