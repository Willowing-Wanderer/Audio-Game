extends Node3D

var circle_1:Node3D
var circle_2:Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Path_East_West/West_End.circle = circle_1
	$Path_East_West/East_End.circle = circle_2
