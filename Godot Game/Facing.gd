extends AkEvent3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_campfire_body_entered(body):
	Wwise.register_game_obj(self, self.get_name())
	Wwise.post_event_id(AK.EVENTS.FACING, self)
	pass # Replace with function body.
