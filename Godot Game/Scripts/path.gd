extends Area3D

@export var circle1:Node3D
@export var circle2:Node3D
@export var player:Node3D
@export var timer:Timer

@export var narrate_path:AkEvent3D
@export var footsteps:AkEvent3D

var object_name = "Path"
const SPEED = 3
var destination = null
var walking = false

func _process(delta):
	if(walking):
		player.position += player.position.direction_to(destination) * SPEED * delta

func narrate():
	narrate_path.post_event()

func on_click(selected):
	player.set_cutscene(true)
	footsteps.post_event()
	if(player.position == circle1.position):
		destination = circle2.position
	else:
		destination = circle1.position
	timer.start()
	walking = true

func _on_timer_timeout():
	player.position = destination
	walking = false
	destination = null
	timer.stop()
	player.set_cutscene(false)
