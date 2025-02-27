extends Node3D

@export var narrate_ending:AkEvent3D
@export var forest_ambience:AkEvent3D

func _on_druid_quest_complete():
	narrate_ending.post_event()
	await get_tree().create_timer(2).timeout
	forest_ambience.post_event()
	await get_tree().create_timer(2).timeout
	get_parent().finish_game()
	queue_free()
