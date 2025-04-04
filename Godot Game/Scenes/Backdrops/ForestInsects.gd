extends Node3D

var forest_insects:AkEvent3D

func _ready():
	forest_insects = $Forest_Insects

func _on_druid_restoration_end_of_event(data):
	get_tree().create_timer(randf_range(0.0,3.5))
	forest_insects.post_event()
 
