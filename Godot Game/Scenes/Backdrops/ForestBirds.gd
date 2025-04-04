extends Node3D

var forest_birds:AkEvent3D

func _ready():
	forest_birds = $Forest_Birds

func _on_druid_restoration_end_of_event(data):
	get_tree().create_timer(randf_range(0.0,3.5))
	forest_birds.post_event()
 
