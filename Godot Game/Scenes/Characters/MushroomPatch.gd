extends Area3D

var mushroom_patch:AkEvent3D
var mushroom_patch_narration:AkEvent3D
var mushroom_pick:AkEvent3D

# Needed if you want to do anything with the player's controls
var player:Node3D

signal quest_complete

var first_click = true

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	mushroom_patch_narration.post_event()

func _on_narrate_druid_end_of_event(data):
	playing_narration = false
	
func stop_narration():
	playing_narration = false
	mushroom_patch_narration.stop_event()
	
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	mushroom_patch = $Mushroom_Patch
	mushroom_patch_narration = $Mushroom_Patch_Narration
	mushroom_pick = $Mushroom_Pick
	mushroom_patch.post_event()

func on_click(selected):
	player.set_cutscene(true)
	await get_tree().create_timer(0.5).timeout
	mushroom_pick.post_event()

func _on_mushroom_pick_end_of_event(data):
	player.add_to_inventory("Mushroom")
	player.set_cutscene(false)
