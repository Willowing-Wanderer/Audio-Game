extends Node

var sounds = {"Empty": AK.EVENTS.CLICK_FAIL,
				"Apple": AK.EVENTS.APPLE,
				"Crystal": AK.EVENTS.CRYSTAL_ITEM,
				"Net": AK.EVENTS.NET_ITEM,
				"Insect": AK.EVENTS.INSECT_ITEM,
				"Mushroom": AK.EVENTS.MUSHROOM_ITEM}

var items = {"Empty": null,
			"Mushroom": 1}
			
var selected = 0

var playing_id

func clean_up():
	var itemsToDelete = []
	for item in items.keys():
		if(items[item] == 0):
			itemsToDelete.append(item)
	for item in itemsToDelete:
		items.erase(item)

func get_selected():
	return items.keys()[selected]
			
func add_item(item_name):
	if(item_name in items.keys()):
		items[item_name] += 1
	else:
		items[item_name] = 1
	
	for i in range(0, items.size()):
		if(items.keys()[i] == item_name):
			selected = i
	
func remove_item(item_name):
	if(item_name in items.keys()):
		items[item_name] -= 1
	clean_up()
	selected = 0
	
func play_selected_sound():
	if(playing_id):
		Wwise.stop_event(playing_id, 500, AkUtils.AK_CURVE_LINEAR)
	Wwise.register_game_obj(self, self.get_name())
	Wwise.post_event_id(sounds[items.keys()[selected]], self)
	
func scroll_up():
	if(selected == items.size()-1):
		selected = 0
	else:
		selected += 1
	play_selected_sound()

func scroll_down():
	if(selected == 0):
		selected = items.size()-1
	else:
		selected -= 1
	play_selected_sound()
