extends Node3D

var crystal_scene = preload("res://Scenes/Items/crystal.tscn")

func _on_raccoon_raccoon_fed():
	var crystal = crystal_scene.instantiate()
	crystal.object_name = "Crystal"
	call_deferred("add_child",crystal)
