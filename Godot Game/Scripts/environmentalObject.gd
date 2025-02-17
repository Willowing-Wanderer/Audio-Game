extends Area3D

@export var object_name:String

# All environmentals must include the following functions

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())

func on_click(selected):
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
