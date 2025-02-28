extends Area3D

@export var object_name:String
@export var circle:Node
@export var player:Node3D

@export var hungry_raccoon:AkEvent3D
@export var raccoon_eating:AkEvent3D
@export var raccoon_thanks:AkEvent3D
@export var raccoon_thanks_2:AkEvent3D
@export var narrate_raccoon:AkEvent3D
@export var narrate_raccoon_satisfied:AkEvent3D
@export var crystal_drop:AkEvent3D
@export var raccoon_go_away:AkEvent3D

signal raccoon_fed
var fed = false

var crystal_scene = preload("res://Scenes/Items/crystal.tscn")

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	hungry_raccoon.post_event()

@export var narration_timer:Timer
@export var narration_timer_2:Timer

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	if(fed):
		narrate_raccoon_satisfied.post_event()
		narration_timer_2.start()
	else:
		narrate_raccoon.post_event()
		narration_timer.start()

func _on_narration_timer_timeout():
	playing_narration = false
	narration_timer.stop()

func _on_narration_timer_2_timeout():
	playing_narration = false
	narration_timer_2.stop()

func stop_narration():
	playing_narration = false
	narrate_raccoon.stop_event()
	narration_timer.stop()
	
func on_click(selected):
	player.set_cutscene(true)
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	
	if(fed):
		raccoon_eating.stop_event()
		raccoon_thanks_2.post_event()
		await get_tree().create_timer(7).timeout
		raccoon_eating.post_event()
	else:
		if(selected == "Apple"):
			player.remove_from_inventory("Apple")
			hungry_raccoon.stop_event()
			raccoon_thanks.post_event()
			await get_tree().create_timer(8).timeout
			drop_crystal()
			raccoon_eating.post_event()
		else:
			hungry_raccoon.stop_event()
			raccoon_go_away.post_event()
			await get_tree().create_timer(2).timeout
			hungry_raccoon.post_event()
			
	player.set_cutscene(false)
	
	
func drop_crystal():
	crystal_drop.post_event()
	var crystal = crystal_scene.instantiate()
	crystal.player = player
	crystal.object_name = "Crystal"
	circle.add_child(crystal)
	raccoon_fed.emit()
	fed = true
