extends Node3D

@export var narrate_controls:AkEvent3D
@export var narrate_ending:AkEvent3D
@export var narrate_start:AkEvent3D
@export var forest_ambience:AkEvent3D
@export var Druid_Path_Dialog:AkEvent3D
@export var Druid_Open_Path:AkEvent3D

@export var player:Area3D

func _ready():
	#$Circle/Druid.player = player
	$Circle2/Raccoon.player = player
	$Circle2/Pixie.player = player
	$Circle3/AppleTree.player = player
	#$"Circle/Path_North-South/North_End".player = player
	#$"Circle/Path_North-South/South_End".player = player
	#print($"Circle/Path_North-South".player)
	#$Path.player = player
	#$Path2.player = player
	pass
	#$Player.set_cutscene(true)
	#narrate_start.post_event()
	#await get_tree().create_timer(20).timeout
	#narrate_controls.post_event()
	#await get_tree().create_timer(27).timeout
	#$Player.set_cutscene(false)
	
func _process(delta):
	$player_ears.position = player.position
	$player_ears.rotation = player.rotation
	pass

func _on_druid_quest_complete():
	Druid_Path_Dialog.post_event()
	#narrate_ending.post_event()
	#await get_tree().create_timer(3.5).timeout
	#forest_ambience.post_event()
	#await get_tree().create_timer(10).timeout
	#get_parent().finish_level_1()
	#queue_free()
	pass

func _on_druid_path_dialog_end_of_event(data):
	Druid_Open_Path.post_event()

func _on_druid_open_path_end_of_event(data):
	get_parent().finish_level_1()
	queue_free()

