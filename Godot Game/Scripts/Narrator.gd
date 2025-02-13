extends Node

var narrations = {"Empty": AK.EVENTS.NARRATE_NOTHING,
				"Apple": AK.EVENTS.NARRATE_APPLE,
				"Campfire": AK.EVENTS.NARRATE_FIRE,
				"Path": AK.EVENTS.NARRATE_PATH,
				"Crystal": AK.EVENTS.NARRATE_CRYSTAL,
				"Apple Tree": AK.EVENTS.NARRATE_APPLE_TREE}
var playing_id

# Called when the node enters the scene tree for the first time.
func _ready():
	Wwise.register_game_obj(self, self.get_name())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func narrate(object_name):
	if(playing_id):
		Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	playing_id = Wwise.post_event_id(narrations[object_name], self)
