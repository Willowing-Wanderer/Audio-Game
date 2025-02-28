extends Area3D

@export var object_name:String = "Druid"

@export var druid_hum:AkEvent3D
@export var druid_dialog:AkEvent3D
@export var druid_help:AkEvent3D
@export var druid_thanks:AkEvent3D

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
		await get_tree().create_timer(5).timeout
		quest_complete.emit()
	else:
		if(first_click):
			druid_dialog.post_event()
			first_click = false
			await get_tree().create_timer(50).timeout
		else:
			druid_help.post_event()
			await get_tree().create_timer(13).timeout
	player.set_cutscene(false)
	druid_hum.post_event()
