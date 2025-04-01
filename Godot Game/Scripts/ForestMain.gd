extends Node3D

var title_screen = preload("res://Scenes/UI/title_screen.tscn")
var raccoon_scene = preload("res://Scenes/Areas/raccoon_scene.tscn")
var cave_scene = preload("res://Scenes/Areas/CaveScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#add_child(title_screen.instantiate())
	finish_level_1()

func start_game():
	var raccoon = raccoon_scene.instantiate()
	raccoon.player = $Player
	add_child(raccoon)

func finish_level_1():
	await get_tree().create_timer(0.1).timeout
	var cave = cave_scene.instantiate()
	cave.player = $Player
	add_child(cave)

func finish_level_2():
	print("hi")
	finish_game()

func finish_game():
	add_child(title_screen.instantiate())

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
