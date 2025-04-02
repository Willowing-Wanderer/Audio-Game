extends Area3D

var bat_bumping:AkEvent3D
var bat_dialog:AkEvent3D
var bat_thanks:AkEvent3D
var bat_narration:AkEvent3D
var bat_cavern_locked:AkEvent3D
var bat_eating:AkEvent3D

var direction = 1
var speed = 0.01
var moving = true
var fed = false

signal cave_unlocked
signal you_path_unlocked

# Needed if you want to do anything with the player's controls
var player:Node3D

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	bat_narration.post_event()

func _on_narrate_druid_end_of_event(data):
	playing_narration = false
	
func stop_narration():
	playing_narration = false
	bat_narration.stop_event()
	
func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	player = get_node("/root/AkBank/AkBank2/ForestMain/Player")
	bat_bumping = $Sounds/Bat_Bumping
	bat_dialog = $Sounds/Bat_Dialog
	bat_thanks = $Sounds/Bat_Thanks
	bat_cavern_locked = $Sounds/Bat_Cavern_Locked
	bat_eating = $Sounds/Bat_Eating
	bat_narration = $Sounds/Bat_Narration
	bat_bumping.post_event()
	
func _process(delta):
	if(moving && !fed):
		rotate_y(speed * direction)

func on_click(selected):
	bat_bumping.stop_event()
	bat_eating.stop_event()
	moving = false
	Wwise.post_event_id(AK.EVENTS.INTERACT, self)
	player.set_cutscene(true)
	await get_tree().create_timer(1).timeout

	if(selected == "Insect"):
		fed = true
		player.remove_from_inventory("Insect")
		cave_unlocked.emit()
		bat_thanks.post_event()
	else:
		if(fed):
			bat_thanks.post_event()
		else:
			bat_dialog.post_event()
			you_path_unlocked.emit()

func _on_timer_timeout():
	direction *= -1

func _on_bat_thanks_end_of_event(data):
	bat_eating.post_event()
	player.set_cutscene(false)

func _on_bat_dialog_end_of_event(data):
	bat_bumping.post_event()
	moving = true
	player.set_cutscene(false)

func _on_bat_cavern_locked_end_of_event(data):
	bat_bumping.post_event()
	moving = true
	player.set_cutscene(false)

func _on_body_entered(body):
	direction *= -1

func on_path_locked():
	player.set_cutscene(true)
	bat_bumping.stop_event()
	moving = false
	bat_cavern_locked.post_event()

func _on_sw_end_path_locked():
	on_path_locked()

func _on_ne_end_path_locked():
	on_path_locked()

func _on_north_end_path_locked():
	on_path_locked()
