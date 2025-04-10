extends Node3D

var player:Node3D
var druid_open_path:AkEvent3D
	
func _ready():
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	druid_open_path = $Druid_Open_Path
	
func _process(delta):
	$player_ears.position = player.position
	$player_ears.rotation = player.rotation

func _on_druid_quest_complete():
	druid_open_path.post_event()

func _on_druid_open_path_end_of_event(data):
	get_parent().finish_level_1()
	queue_free()

