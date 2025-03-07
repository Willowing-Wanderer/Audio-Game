extends Area3D

@export var object_name:String

@export var environmental:AkEvent3D
@export var narrate_environmental:AkEvent3D

var playing_narration = false

# All environmentals must include the following functions

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())

func narrate():
	narrate_environmental.post_event()
	playing_narration = true

func stop_narration():
	narrate_environmental.stop_event()
	playing_narration = false

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)

func _on_narrate_environmental_end_of_event(data):
	playing_narration = false
