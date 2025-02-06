extends AkEvent3D

var playing_id

# Called when the node enters the scene tree for the first time.
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	playing_id = Wwise.post_event_id(AK.EVENTS.FIRE_DIM, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_whoosh_fire_low():
	Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	playing_id = Wwise.post_event_id(AK.EVENTS.FIRE_LOW, self)

func _on_whoosh_fire_medium():
	Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	playing_id = Wwise.post_event_id(AK.EVENTS.FIRE_MEDIUM, self)
	

func _on_whoosh_fire_high():
	Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	playing_id = Wwise.post_event_id(AK.EVENTS.FIRE_HIGH, self)


func _on_whoosh_fire_done():
	#Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	playing_id = Wwise.post_event_id(AK.EVENTS.DRUIDS_MESSAGE, self)
