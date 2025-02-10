extends Area3D
@export var player:Node3D

@export var item_name:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# All items must include the following functions:
func on_click():
	player.add_to_inventory(item_name)
	
	Wwise.register_game_obj(self, self.get_name())
	Wwise.set_3d_position(self, get_global_transform())
	Wwise.post_event_id(AK.EVENTS.PICK_UP, self)
	
	queue_free()
	
