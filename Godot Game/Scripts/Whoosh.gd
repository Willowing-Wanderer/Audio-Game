extends AkEvent3D

var sticks = 0
signal fire_low
signal fire_medium
signal fire_high
signal fire_done

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_stick_added():
	#print("campfire received")
	#print(self.get_name())
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.FIRE_WHOOSH, self)
	sticks += 1
	if(sticks >= 2):
		fire_low.emit()
	if(sticks >= 4):
		fire_low.emit()
	if(sticks >= 6):
		fire_high.emit()
		fire_done.emit()
