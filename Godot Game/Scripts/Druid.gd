extends Area3D

@export var object_name:String = "Druid"

# Needed if you want to do anything with the player's controls
@export var player:Node3D

var first_click = true

# All environmentals must include the following functions

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.stop_facing()
	player.set_process_input(false)
	player.set_process_unhandled_input(false)
	await get_tree().create_timer(1).timeout
	if(first_click):
		Wwise.post_event_id(AK.EVENTS.DRUID_DIALOG, self)
		first_click = false
		await get_tree().create_timer(3).timeout
	else:
		if(selected == "Crystal"): # win condition
			Wwise.post_event_id(AK.EVENTS.DRUID_THANKS, self)
			await get_tree().create_timer(5).timeout
		else:
			Wwise.post_event_id(AK.EVENTS.DRUID_HELP, self)
			await get_tree().create_timer(1).timeout
	player.set_process_input(true)
	player.set_process_unhandled_input(true)
