extends Area3D

@export var object_name:String

@export var narrate_environmental:AkEvent3D

# All environmentals must include the following functions

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())

func narrate():
	narrate_environmental.post_event()

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
