extends Node3D

var cave_entrance_scene = preload("res://Scenes/Areas/CaveEntrancePath.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mother_bear_cave_unlocked():
	var cave_entrance_path = cave_entrance_scene.instantiate()
	cave_entrance_path.circle_1 = $"."
	cave_entrance_path.circle_2 = $"../CaveFoyer"
	add_child(cave_entrance_path)
