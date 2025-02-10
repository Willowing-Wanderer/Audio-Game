extends Node

var arr = [2,3,4]

var items = {"Empty": null,
			"Apple": 1,
			"Druid's Staff" : 1}
			
var selected = 0

func _ready():
	print(items)

func _process(delta):
	var itemsToDelete = []
	for item in items.keys():
		if(items[item] == 0):
			itemsToDelete.append(item)
	for item in itemsToDelete:
		items.erase(item)
	
			
func add_item(item_name):
	if(item_name in items.keys()):
		items[item_name] += 1
	else:
		items[item_name] = 1
	
func play_selected_sound():
	print(items.keys()[selected])
	
func scroll_up():
	if(selected == items.size()-1):
		selected = 0
	else:
		selected += 1

func scroll_down():
	if(selected == 0):
		selected = items.size()-1
	else:
		selected -= 1
