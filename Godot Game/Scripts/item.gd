extends Area3D
var player:Node3D

@export var object_name:String
@export var narrate_item:AkEvent3D
var item_ping:AkEvent3D

var playing_narration = false

func _ready():
	item_ping = $ItemEvent
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	item_ping.post_event()

# All items must include the following functions:
func narrate():
	playing_narration = true
	narrate_item.post_event()
	
func stop_narration():
	playing_narration = false
	narrate_item.stop_event()

func on_click(_selected):
	player.add_to_inventory(object_name)
	print(object_name)
	item_ping.stop_event()
	visible = false

func _on_narrate_item_end_of_event(_data):
	playing_narration = false
