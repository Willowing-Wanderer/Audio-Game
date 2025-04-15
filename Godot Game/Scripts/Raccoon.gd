extends Area3D

@export var object_name:String
@export var circle:Node
var player:Node3D

var hungry_raccoon:AkEvent3D
var raccoon_eating:AkEvent3D
var raccoon_thanks:AkEvent3D
var raccoon_thanks_2:AkEvent3D
var narrate_raccoon:AkEvent3D
var narrate_raccoon_satisfied:AkEvent3D
var crystal_drop:AkEvent3D
var raccoon_go_away:AkEvent3D

var playing_narration = false
signal raccoon_fed
var fed = false

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	hungry_raccoon = $Hungry_Raccoon
	raccoon_eating = $Raccoon_Eating
	raccoon_thanks = $Raccoon_Thanks
	narrate_raccoon = $Narrate_Raccoon
	crystal_drop = $Crystal_Drop
	raccoon_go_away = $Raccoon_Go_Away
	narrate_raccoon_satisfied = $Narrate_Raccoon_Satisfied
	raccoon_thanks_2 = $Raccoon_Thanks_2
	hungry_raccoon.post_event()


func narrate():
	playing_narration = true
	if(fed):
		narrate_raccoon_satisfied.post_event()
	else:
		narrate_raccoon.post_event()

func stop_narration():
	playing_narration = false
	narrate_raccoon.stop_event()
	
func on_click(selected):
	player.set_cutscene(true)

	if(fed):
		raccoon_eating.stop_event()
		raccoon_thanks_2.post_event()
	else:
		if(selected == "Apple"):
			player.remove_from_inventory("Apple")
			hungry_raccoon.stop_event()
			raccoon_thanks.post_event()
		else:
			hungry_raccoon.stop_event()
			raccoon_go_away.post_event()
	
func drop_crystal():
	crystal_drop.post_event()
	raccoon_fed.emit() # also connecting this to Raccoon_Circle
	fed = true

func _on_narrate_raccoon_satisfied_end_of_event(data):
	playing_narration = false

func _on_narrate_raccoon_end_of_event(data):
	playing_narration = false

func _on_raccoon_thanks_2_end_of_event(data):
	raccoon_eating.post_event()
	player.set_cutscene(false)

func _on_raccoon_thanks_end_of_event(data):
	drop_crystal()
	raccoon_eating.post_event()
	player.set_cutscene(false)

func _on_raccoon_go_away_end_of_event(data):
	hungry_raccoon.post_event()
	player.set_cutscene(false)
