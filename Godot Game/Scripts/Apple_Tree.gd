extends Area3D

@export var object_name:String
@export var circle:Node

var apple_scene = preload("res://Scenes/Items/apple.tscn")

func _ready():
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())

func on_click(selected):
	Wwise.post_event_id(AK.EVENTS.TREE_SHAKE, self)
	await get_tree().create_timer(3).timeout
	Wwise.post_event_id(AK.EVENTS.APPLES_FALL, self)
	var apple1 = apple_scene.instantiate()
	var apple2 = apple_scene.instantiate()
	var apple3 = apple_scene.instantiate()
	apple1.rotation = Vector3(0,deg_to_rad(20),0)
	apple2.rotation = Vector3(0,deg_to_rad(-50),0)
	apple3.rotation = Vector3(0,deg_to_rad(150),0)
	# have to assign player to each apple
	circle.add_child(apple1)
	circle.add_child(apple2)
	circle.add_child(apple3)
	# play tree shake
	# play apples falling
	# spawn apples
	
	#Wwise.register_game_obj(self, self.get_name())
	#Wwise.set_3d_position(self, get_global_transform())
	#Wwise.post_event_id(AK.EVENTS.INTERACT, self)
