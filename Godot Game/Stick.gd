extends AkEvent3D

var playing_id
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_stick_body_entered(body):
	play_stick_sound()


func _on_stick_2_body_entered(body):
	play_stick_sound()


func _on_stick_3_body_entered(body):
	play_stick_sound()
	
func play_stick_sound():
	Wwise.register_game_obj(self, self.get_name())
	playing_id = Wwise.post_event_id(AK.EVENTS.FACING_STICK, self)

func stop_stick_sound():
	Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)

func _on_stick_body_exited(body):
	stop_stick_sound()

func _on_stick_2_body_exited(body):
	stop_stick_sound()

func _on_stick_3_body_exited(body):
	stop_stick_sound()
