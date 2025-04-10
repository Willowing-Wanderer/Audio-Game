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
	player.set_cutscene(true)
	pixie_humming_2.stop_event()
	if(selected == "Mushroom" && player.get_count("Mushroom") >= 5):
		for i in range(0,5):
			player.remove_from_inventory("Mushroom")
		pixie_trade_2.post_event()
		await get_tree().create_timer(5).timeout
		drop_crystal()
	else:
		pixie_dialog_2.post_event()

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
	crystal.rotation = Vector3(0,deg_to_rad(73),0)
	circle.add_child(crystal)
	print(crystal)
	print(circle.get_children())
	print("Should have added a crystal")
