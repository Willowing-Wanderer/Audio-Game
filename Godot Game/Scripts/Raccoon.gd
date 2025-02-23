extends Area3D

@export var object_name:String

@export var hungry_raccoon:AkEvent3D
@export var raccoon_eating:AkEvent3D
@export var raccoon_thanks:AkEvent3D
@export var narrate_raccoon:AkEvent3D

# All environmentals must include the following functions

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	hungry_raccoon.post_event()

func narrate():
	narrate_raccoon.post_event()

func on_click(selected):
	if(selected == "Apple"):
		Wwise.post_event_id(AK.EVENTS.INTERACT, self)
		hungry_raccoon.stop_event()
		raccoon_thanks.post_event()
		await get_tree().create_timer(5).timeout
		raccoon_eating.post_event()
		drop_crystal()
	else:
		Wwise.post_event_id(AK.EVENTS.CLICK_FAIL, self)
		
func drop_crystal():
	pass
