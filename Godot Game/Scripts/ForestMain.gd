extends Node3D

var title_screen
var title_menu = preload("res://Scenes/UI/TitleMenu.tscn")
var raccoon_scene = preload("res://Scenes/Areas/raccoon_scene.tscn")
var cave_scene = preload("res://Scenes/Areas/CaveScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	title_screen = title_menu.instantiate()
	add_child(title_screen)

func start_game():
	remove_child(title_screen)
	var raccoon = raccoon_scene.instantiate()
	raccoon.player = $Player
	add_child(raccoon)

func finish_level_1():
	await get_tree().create_timer(0.1).timeout
	var cave = cave_scene.instantiate()
	cave.player = $Player
	add_child(cave)

func finish_level_2():
	call_deferred("add_child",title_screen.instantiate())
	
func _input(event):
	pass
