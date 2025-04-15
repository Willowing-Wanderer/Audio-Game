extends Area3D

var object_name:String
var pixie_giggle:AkEvent3D
var pixie_aww:AkEvent3D
var pixie_flyoff:AkEvent3D
var pixie1_dialog:AkEvent3D
var narrate_pixie:AkEvent3D
var player:Node3D

var playing_narration = false

var crystal_scene = preload("res://Scenes/Items/crystal.tscn")

func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	pixie_giggle = $Pixie_Giggle
	pixie_aww = $Pixie_Aww
	pixie_flyoff = $Pixie_Flyoff
	pixie1_dialog = $Pixie1_Dialog
	narrate_pixie = $Narrate_Pixie
	pixie_giggle.post_event()

func narrate():
	playing_narration = true
	narrate_pixie.post_event()

func on_click(_selected):
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout
	pixie_giggle.stop_event()
	pixie1_dialog.post_event()
	
func _on_raccoon_raccoon_fed():
	player.set_cutscene(true)
	pixie_giggle.stop_event()
	await get_tree().create_timer(2).timeout
	pixie_aww.post_event()

func stop_narration():
	playing_narration = false
	narrate_pixie.stop_event()

func _on_narrate_pixie_end_of_event(_data):
	playing_narration = false

func _on_pixie_1_dialog_end_of_event(_data):
	pixie_giggle.post_event()
	player.set_cutscene(false)

func _on_pixie_aww_end_of_event(_data):
	pixie_flyoff.post_event()

func _on_pixie_flyoff_end_of_event(_data):
	player.set_cutscene(false)
	queue_free()
