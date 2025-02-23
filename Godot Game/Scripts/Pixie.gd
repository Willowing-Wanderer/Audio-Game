extends Area3D

@export var object_name:String

@export var pixie_giggle:AkEvent3D
@export var pixie_aww:AkEvent3D
@export var pixie_flyoff:AkEvent3D
@export var pixie1_dialog:AkEvent3D
@export var narrate_pixie:AkEvent3D

@export var player:Node3D

var crystal_scene = preload("res://Scenes/Items/crystal.tscn")

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	pixie_giggle.post_event()

func narrate():
	narrate_pixie.post_event()

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.stop_facing()
	player.set_process_input(false)
	
	pixie_giggle.stop_event()
	pixie1_dialog.post_event()
	
	await get_tree().create_timer(10.1).timeout
	
	pixie_giggle.post_event()
	player.set_process_input(true)
	
func _on_raccoon_raccoon_fed():
	pixie_giggle.stop_event()
	await get_tree().create_timer(3).timeout
	pixie_aww.post_event()
	await get_tree().create_timer(1).timeout
	pixie_flyoff.post_event()
	queue_free()
	
