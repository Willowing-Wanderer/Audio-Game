extends Node3D

@export var narrate_controls:AkEvent3D
@export var narrate_ending:AkEvent3D
@export var narrate_start:AkEvent3D
@export var forest_ambience:AkEvent3D
@export var player:Area3D

func _ready():
	$Player.set_cutscene(true)
	#narrate_start.post_event()
	#await get_tree().create_timer(20).timeout
	#narrate_controls.post_event()
	#await get_tree().create_timer(27).timeout
	$Player.set_cutscene(false)

func _on_druid_quest_complete():
	narrate_ending.post_event()
	await get_tree().create_timer(3.5).timeout
	forest_ambience.post_event()
	await get_tree().create_timer(10).timeout
	get_parent().finish_game()
	queue_free()

