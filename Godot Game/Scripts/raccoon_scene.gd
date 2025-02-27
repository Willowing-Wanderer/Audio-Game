extends Node3D

@export var narrate_controls:AkEvent3D
@export var narrate_ending:AkEvent3D
@export var forest_ambience:AkEvent3D

func _ready():
	$Player.set_cutscene(true)
	narrate_controls.post_event()
	await get_tree().create_timer(9).timeout
	$Player.set_cutscene(false)

func _on_druid_quest_complete():
	narrate_ending.post_event()
	await get_tree().create_timer(3.5).timeout
	forest_ambience.post_event()
	await get_tree().create_timer(5).timeout
	get_parent().finish_game()
	queue_free()
