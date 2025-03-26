extends Node3D

@export var player:Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	#$CaveEntrance/Entrance.player = player
	#$CaveFoyer/FoyerPath.player = player
	#$WhisperingCavern1/I.player = player
	#$WhisperingCavern1/You.player = player
	#$WhisperingCavern1/We.player = player
	#$WhisperingCavern2/Love.player = player
	#$WhisperingCavern2/Hate.player = player
	#$WhisperingCavern13/You.player = player
	#$WhisperingCavern13/Myself.player = player
	#$WhisperingCavern14/Fear.player = player
	#$WhisperingCavern3/Exist.player = player
	#$WhisperingCavern3/Belong.player = player
	#$WhisperingCavern6/Alone.player = player
	#$WhisperingCavern7/Here.player = player
	#$WhisperingCavern7/Asleep.player = player
	#$WhisperingCavern4/Survive.player = player
	#$WhisperingCavern4/Die.player = player
	#$WhisperingCavern11/Apart.player = player
	#$WhisperingCavern5/Together.player = player
	#$Campsite/Path.player = player
	#$"Apple Tree/AppleTree".player = player
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$player_ears.position = player.position
	$player_ears.rotation = player.rotation
