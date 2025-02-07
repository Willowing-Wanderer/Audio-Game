extends Area3D

@export var circle1:Node3D
@export var circle2:Node3D
@export var player:Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_click():
	# move the player from circle 1 to circle 2
	# how will I account for going the other way?
	player.set_process_input(false)
	player.set_process_unhandled_input(false)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.FOOTSTEPS, self)
	await get_tree().create_timer(3).timeout
	if(player.position == circle1.position):
		player.position = circle2.position
	else:
		player.position = circle1.position
	player.set_process_input(true)
	player.set_process_unhandled_input(true)
