extends Area3D

@export var object_name:String = "Druid"

@export var druid_hum:AkEvent3D
@export var druid_dialog:AkEvent3D
@export var druid_help:AkEvent3D
@export var druid_thanks:AkEvent3D
@export var druid_restoration:AkEvent3D

# Needed if you want to do anything with the player's controls
@export var player:Node3D

signal quest_complete

var first_click = true

@export var narration_timer:Timer
@export var narrate_item:AkEvent3D

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	narrate_item.post_event()
	narration_timer.start()

func _on_narration_timer_timeout():
	playing_narration = false
	narration_timer.stop()
	
func stop_narration():
	playing_narration = false
	narrate_item.stop_event()
	narration_timer.stop()
	
func _ready():
	#TODO: Remove this before shipping
	druid_thanks.post_event()
	
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	druid_hum.post_event()

func on_click(selected):
	druid_hum.stop_event()
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout
	
	if(selected == "Crystal"):
		player.remove_from_inventory("Crystal")
		druid_thanks.post_event()
	else:
		if(first_click):
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
	quest_complete.emit()


