extends Node3D

@export var narrate_ending:AkEvent3D

func _on_druid_quest_complete():
	narrate_ending.post_event()
	await get_tree().create_timer(3).timeout
	get_parent().finish_game()
	queue_free()
