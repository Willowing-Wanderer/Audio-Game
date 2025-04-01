extends Area3D

var pixie_humming_2:AkEvent3D
var pixie_trade_2:AkEvent3D
var pixie_flyoff:AkEvent3D
var pixie_dialog_2:AkEvent3D
var narrate_pixie:AkEvent3D
var crystal_drop:AkEvent3D
var player:Node3D
@export var circle:Node3D

var playing_narration = false

var crystal_scene = preload("res://Scenes/Items/crystal.tscn")

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	pixie_humming_2 = $Pixie_Humming_2
	pixie_trade_2 = $Pixie_Trade_2
	pixie_flyoff = $Pixie_Flyoff
	pixie_dialog_2 = $Pixie_Dialog_2
	narrate_pixie = $Narrate_Pixie
	crystal_drop = $Crystal_Drop
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	pixie_humming_2.post_event()

func narrate():
	playing_narration = true
	narrate_pixie.post_event()
	
func stop_narration():
	playing_narration = false
	narrate_pixie.stop_event()

func _on_narrate_pixie_end_of_event(data):
	playing_narration = false
	
func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout
	pixie_humming_2.stop_event()
	
	if(selected == "Mushroom"):
		player.remove_from_inventory("Mushroom")
		pixie_trade_2.post_event()
	else:
		pixie_dialog_2.post_event()
	
func _on_pixie_trade_2_end_of_event(data):
	drop_crystal()

func _on_crystal_drop_end_of_event(data):
	pixie_flyoff.post_event()

func _on_pixie_flyoff_end_of_event(data):
	queue_free()
	player.set_cutscene(false)

func _on_pixie_dialog_2_end_of_event(data):
	pixie_humming_2.post_event()
	player.set_cutscene(false)

func drop_crystal():
	crystal_drop.post_event()
	var crystal = crystal_scene.instantiate()
	crystal.player = player
	crystal.object_name = "Crystal"
	circle.add_child(crystal)
