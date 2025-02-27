extends Node3D

var title_screen = preload("res://Scenes/UI/title_screen.tscn")
var raccoon_scene = preload("res://Scenes/Areas/raccoon_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(title_screen.instantiate())

func start_game():
	add_child(raccoon_scene.instantiate())

func finish_game():
	add_child(title_screen.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

