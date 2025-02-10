extends Node

var arr = [2,3,4]

var items = {"Empty": null,
			"Apple" : 0,
			"Stick" : 0,
			"Druid's Staff" : 1}
			
var selected = 0
			
			
func add_item(item_name):
	items[item_name] += 1
	
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
	
#func place(item_name):
	#print("placing " + item_name)
	# This is actually not how our game works at the moment, items will be placed with interactables only
