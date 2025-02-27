extends Area3D

@export var object_name:String
@export var pixie_giggle:AkEvent3D
@export var pixie_aww:AkEvent3D
@export var pixie_flyoff:AkEvent3D
@export var pixie1_dialog:AkEvent3D
@export var narrate_pixie:AkEvent3D
@export var narration_timer:Timer
@export var player:Node3D

var playing_narration = false

var crystal_scene = preload("res://Scenes/Items/crystal.tscn")

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	pixie_giggle.post_event()

func narrate():
	playing_narration = true
	narrate_pixie.post_event()
	narration_timer.start()

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.set_cutscene(true)
	
	pixie_giggle.stop_event()
	pixie1_dialog.post_event()
	
	await get_tree().create_timer(2.6).timeout
	
	pixie_giggle.post_event()
	player.set_cutscene(false)
	
func _on_raccoon_raccoon_fed():
	player.set_cutscene(true)
	pixie_giggle.stop_event()
	await get_tree().create_timer(2).timeout
	pixie_aww.post_event()
	await get_tree().create_timer(2).timeout
	pixie_flyoff.post_event()
	await get_tree().create_timer(3).timeout
	player.set_cutscene(false)
	queue_free()

func _on_narration_timer_timeout():
	playing_narration = false
	narration_timer.stop()

func stop_narration():
	playing_narration = false
	narrate_pixie.stop_event()
	narration_timer.stop()
