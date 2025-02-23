extends Area3D
@export var player:Node3D

@export var object_name:String

@export var narrate_item:AkEvent3D
# All items must include the following functions:
func narrate():
	narrate_item.post_event()

func on_click(selected):
	player.add_to_inventory(object_name)
	
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.PICK_UP, self)
	
	queue_free()
	
