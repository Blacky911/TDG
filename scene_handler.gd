extends Node

func _ready():
	load_main_menu()

func load_main_menu():
	get_node("MainMenu/M/VB/NewGame").connect("pressed", on_new_game_pressed)
	get_node("MainMenu/M/VB/Quit").connect("pressed", on_quit_pressed)

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	add_child(game_scene)
	
func on_quit_pressed():
	get_tree().quit()

func unload_game(_result):	
	get_node("GameScene").queue_free()
	var main_menu = load("res://Scenes/UIScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
