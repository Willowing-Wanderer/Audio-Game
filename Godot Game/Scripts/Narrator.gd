extends Node

var narrations = {"Empty": AK.EVENTS.NARRATE_NOTHING,
				"Apple": AK.EVENTS.NARRATE_APPLE,
				"Crystal": AK.EVENTS.NARRATE_CRYSTAL,
				"Net": AK.EVENTS.NET_ITEM_NARRATION,
				"Insect": AK.EVENTS.INSECT_ITEM_NARRATION,
				"Mushroom": AK.EVENTS.MUSHROOM_NARRATION}
var playing_id
var playing_narration = false

@export var narration_timer:Timer
@export var crystal_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	Wwise.register_game_obj(self, self.get_name())

func narrate(object_name):
	playing_narration = true
	playing_id = Wwise.post_event_id(narrations[object_name], self)
	if(object_name == "Crystal"):
		crystal_timer.start()
	else:
		narration_timer.start()

func _on_narration_timer_timeout():
	playing_narration = false
	narration_timer.stop()
	
func stop_narration():
	playing_narration = false
	if(playing_id):
		Wwise.stop_event(playing_id, 0 ,AkUtils.AK_CURVE_LINEAR)
	narration_timer.stop()

func _on_crystal_timer_timeout():
	playing_narration = false
	crystal_timer.stop()
