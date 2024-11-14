extends AkEvent3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.CAMPFIRE, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
