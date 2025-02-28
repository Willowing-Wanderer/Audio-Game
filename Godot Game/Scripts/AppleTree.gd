extends Area3D

@export var object_name:String = "Apple Tree"
@export var circle:Node
@export var player:Node3D

@export var tree_swish:AkEvent3D
@export var tree_shake:AkEvent3D
@export var apples_fall:AkEvent3D
@export var narrate_apple_tree:AkEvent3D
@export var narrate_empty_tree:AkEvent3D
@export var interact:AkEvent3D
@export var narration_timer:Timer

var apple_scene = preload("res://Scenes/Items/apple.tscn")

var has_apples = true

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	tree_swish.post_event()

var playing_narration = false

# All items must include the following functions:
func narrate():
	playing_narration = true
	if(has_apples):
		narrate_apple_tree.post_event()
	else:
		narrate_empty_tree.post_event()
	narration_timer.start()

func _on_narration_timer_timeout():
	playing_narration = false
	narration_timer.stop()
	
func stop_narration():
	playing_narration = false
	if(has_apples):
		narrate_apple_tree.stop_event()
	else:
		narrate_empty_tree.stop_event()
	narration_timer.stop()

func on_click(selected):
	player.set_cutscene(true)
	interact.post_event()
	await get_tree().create_timer(0.8).timeout
	tree_shake.post_event()
	await get_tree().create_timer(0.8).timeout
	
	if(has_apples):
		apples_fall.post_event()
		var apple1 = apple_scene.instantiate()
		var apple2 = apple_scene.instantiate()
		var apple3 = apple_scene.instantiate()
		apple1.rotation = Vector3(0,deg_to_rad(20),0)
		apple1.player = player
		apple1.object_name = "Apple"
		apple2.rotation = Vector3(0,deg_to_rad(-50),0)
		apple2.player = player
		apple2.object_name = "Apple"
		apple3.rotation = Vector3(0,deg_to_rad(150),0)
		apple3.player = player
		apple3.object_name = "Apple"
		circle.add_child(apple1)
		circle.add_child(apple2)
		circle.add_child(apple3)
		
		has_apples = false
		
	player.set_cutscene(false)
