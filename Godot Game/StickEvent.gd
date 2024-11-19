extends AkEvent3D

var playing_id

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_stick_area_entered(area):
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	playing_id = Wwise.post_event_id(AK.EVENTS.FACING_STICK, self)


func _on_stick_area_exited(area):
	Wwise.stop_event(playing_id, 100, AkUtils.AK_CURVE_LINEAR)
