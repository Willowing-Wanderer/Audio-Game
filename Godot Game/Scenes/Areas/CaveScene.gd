extends Node3D

@export var player:Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$player_ears.position = player.position
	$player_ears.rotation = player.rotation

func _on_druid_2_quest_complete():
	get_parent().finish_level_2()
	queue_free()
