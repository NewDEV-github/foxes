extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var new_chrs = Globals.new_characters
#var discord_rpc = DISCORD_RPC.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_chrs = Globals.new_characters
	print(str(new_chrs))
	for character in new_chrs:
		$ItemList.add_item(str(character))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func after_selecting_player():
	BackgroundLoad.load_scene(str(Globals.world))


func _on_ItemList_item_selected(index):
	var item_name = $ItemList.get_item_text(index)
#	discord_rpc.set_details('Playing as ' + str(item_name))
	Globals.character_path = "res://Scenes/Characters/" + str(item_name) + ".tscn"
	Globals.selected_character = load("res://Scenes/Characters/" + str(item_name) + ".tscn").instance()
	after_selecting_player()
