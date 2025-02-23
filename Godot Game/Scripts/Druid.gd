extends Area3D

@export var object_name:String = "Druid"

@export var druid_hum:AkEvent3D
@export var druid_dialog:AkEvent3D
@export var druid_help:AkEvent3D
@export var druid_thanks:AkEvent3D
@export var narrate_druid:AkEvent3D

# Needed if you want to do anything with the player's controls
@export var player:Node3D

var first_click = true

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	druid_hum.post_event()
	
func narrate():
	narrate_druid.post_event()

func on_click(selected):
	druid_hum.stop_event()
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.stop_facing()
	player.set_process_input(false)
	#TODO: turn off facing sounds as well somehow
	#player.set_process_unhandled_input(false)
	await get_tree().create_timer(1).timeout
	if(first_click):
		druid_dialog.post_event()
		first_click = false
		await get_tree().create_timer(50).timeout
	else:
		if(selected == "Crystal"): # win condition
			druid_thanks.post_event()
			await get_tree().create_timer(5).timeout
		else:
			druid_help.post_event()
			await get_tree().create_timer(11.1).timeout
	player.set_process_input(true)
	#player.set_process_unhandled_input(true)
	druid_hum.post_event()
