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
	if(player.position == circle1.position):
		player.position = circle2.position
	else:
		player.position = circle1.position
	pass
