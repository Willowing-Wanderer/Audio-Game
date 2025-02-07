extends Node

var arr = [2,3,4]

var dict = {"Name" : "Gwizz",
			"Age" : 20,
			"favNums" : arr}
			
# Called when the node enters the scene tree for the first time.
func _ready():
	print(dict["favNuns"][0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
