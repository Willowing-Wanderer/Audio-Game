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
	call_deferred("free") # using this instead of queue_free() because of random crashing

func _on_narrate_item_end_of_event(data):
	playing_narration = false
