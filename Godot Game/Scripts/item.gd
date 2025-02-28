extends Area3D
@export var player:Node3D

@export var object_name:String
@export var narration_timer:Timer
@export var narrate_item:AkEvent3D

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	narrate_item.post_event()
	narration_timer.start()

func _on_narration_timer_timeout():
	playing_narration = false
	narration_timer.stop()
	
func stop_narration():
	playing_narration = false
	narrate_item.stop_event()
	narration_timer.stop()

func on_click(selected):
	player.add_to_inventory(object_name)
	
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.PICK_UP, self)
	
	queue_free()
