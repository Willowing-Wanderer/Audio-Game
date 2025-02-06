extends AkEvent3D

var playing_id
var ids = []
var player_in_area = false
var started_timer = false
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player_in_area && !started_timer):
		started_timer = true
		timer = Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.start()
		timer.connect("timeout", _on_timer_timeout)
		play_stick_sound()
	
	#print(self.name)


func play_stick_sound():
	if(self.name == "TinderEvent"):
		playing_id = Wwise.post_event_id(AK.EVENTS.TINDER, self)
	if(self.name == "KindlingEvent"):
		playing_id = Wwise.post_event_id(AK.EVENTS.KINDLING, self)
	if(self.name == "FuelEvent"):
		playing_id = Wwise.post_event_id(AK.EVENTS.FUEL, self)

func _on_stick_area_entered(area):
	player_in_area = true
	#if(ids.size() > 0):
		#for id in ids:
			#print("Catch1 stopped %s" % id)
			#Wwise.stop_event(id, 100, AkUtils.AK_CURVE_LINEAR)
		#ids = []
		
	
	#playing_id = Wwise.post_event_id(AK.EVENTS.FACING_STICK, self)
	#print("Started %s" % playing_id)
	#ids.append(playing_id)


func _on_stick_area_exited(area):
	player_in_area = false
	timer.queue_free()
	started_timer = false
	#print("Stopped %s" % playing_id)
	#Wwise.stop_event(playing_id, 100, AkUtils.AK_CURVE_LINEAR)
	#if(ids.size() > 0):
		#for id in ids:
			#print("Catch2 stopped %s" % id)
			#Wwise.stop_event(id, 100, AkUtils.AK_CURVE_LINEAR)
		#ids = []


func _on_timer_timeout():
	play_stick_sound()
