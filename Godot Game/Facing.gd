extends AkEvent3D

var playing_id

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_campfire_body_entered(body):
	Wwise.register_game_obj(self, self.get_name())
	playing_id = Wwise.post_event_id(AK.EVENTS.FACING, self)
	#print(playing_id)
	pass


func _on_campfire_body_exited(body):
	#print(playing_id)
	Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	pass
