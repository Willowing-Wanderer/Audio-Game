extends Area3D

@export var object_name:String = "Apple Tree"
@export var circle:Node
@export var player:Node3D

@export var tree_swish:AkEvent3D
@export var tree_shake:AkEvent3D
@export var apples_fall:AkEvent3D
@export var narrate_apple_tree:AkEvent3D

var apple_scene = preload("res://Scenes/Items/apple.tscn")

var has_apples = true

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	tree_swish.post_event()
	
func narrate():
	narrate_apple_tree.post_event()

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.INTERACT, player)
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
		
