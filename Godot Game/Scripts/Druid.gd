extends Area3D

@export var object_name:String = "Druid"

var druid_hum:AkEvent3D
var druid_dialog:AkEvent3D
var druid_help:AkEvent3D
var druid_thanks:AkEvent3D
var druid_restoration:AkEvent3D
var druid_path_dialog:AkEvent3D
var druid_nervous:AkEvent3D

var player:Node3D

signal quest_complete

var first_click = true

var narrate_druid:AkEvent3D

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
	druid_dialog = $Druid_Dialog
	druid_help = $Druid_Help
	druid_thanks = $Druid_Thanks
	druid_restoration = $Druid_Restoration
	druid_path_dialog = $Druid_Path_Dialog
	druid_nervous = $Druid_Nervous
	druid_nervous.post_event()

func on_click(selected):
	druid_nervous.stop_event()
	druid_hum.stop_event()
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout
	
	if(selected == "Crystal"):
		player.remove_from_inventory("Crystal")
		druid_thanks.post_event()
	else:
		if(first_click):
			player.set_cutscene(true)
			druid_dialog.post_event()
			first_click = false
		else:
			druid_help.post_event()
			await get_tree().create_timer(6).timeout

func _on_druid_thanks_end_of_event(data):
	druid_restoration.post_event()

func _on_druid_dialog_end_of_event(data):
	player.set_cutscene(false)
	druid_hum.post_event()

func _on_druid_help_end_of_event(data):
	player.set_cutscene(false)
	druid_hum.post_event()

func _on_druid_restoration_end_of_event(data):
	druid_path_dialog.post_event()

func _on_druid_path_dialog_end_of_event(data):
	player.set_cutscene(false)
	quest_complete.emit()

