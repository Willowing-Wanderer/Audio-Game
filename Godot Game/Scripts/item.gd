extends Area3D
var player:Node3D

@export var object_name:String
@export var narrate_item:AkEvent3D

var playing_narration = false

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")

# All items must include the following functions:
func narrate():
	playing_narration = true
	narrate_item.post_event()
	
func stop_narration():
	playing_narration = false
	narrate_item.stop_event()

func on_click(selected):
	player.add_to_inventory(object_name)
	
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.PICK_UP, self)
	
	queue_free()

func _on_narrate_item_end_of_event(data):
	playing_narration = false
