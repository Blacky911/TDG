extends Node2D

signal game_finished(result)

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

var current_wave = 0
var max_wave = 3
var enemies_in_wave = 0

var base_health = 100
var bank_account = 500

func _ready():
	map_node = get_node("Map01")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	get_node("UI").update_bank_account()
	waves_loop()

func _process(_delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave funcs
##
func waves_loop():
	var delay
	for i in range(current_wave, max_wave):
		randomize()
		delay = (randf() * 10.0) + 5.0
		await (get_tree().create_timer(delay).timeout)
		current_wave += 1
		start_next_wave()
	if current_wave == max_wave:
		await (get_tree().create_timer(5).timeout)
		var number_of_enemies_alive
		while true:
			number_of_enemies_alive = map_node.get_node("Path").get_child_count()
			await (get_tree().create_timer(1).timeout)
			if number_of_enemies_alive == 0:
				break
		var ui = get_node("UI")
		ui.show_text_overlay("You have won!")
		await get_tree().create_timer(3.0).timeout
		ui.hide_text_overlay()
		on_quit()

func start_next_wave():
	var wave_data = retrieve_wave_data()
	spawn_enemies(wave_data)

func retrieve_wave_data():
	var delay
	var wave_data = []
	for i in range(0, current_wave):
		randomize()
		delay = (randf() * 1.8) + 0.2
		wave_data.append(["blue_tank", delay])
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
		new_enemy.connect("base_damage", on_base_damage)
		map_node.get_node("Path").add_child(new_enemy, true)
		await (get_tree().create_timer(i[1]).timeout)


##
## Building funcs
##
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = (tower_type + "T1").to_snake_case()
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)

	if map_node.get_node("TowerExclusion").get_cell_source_id(current_tile):
		get_node("UI").update_tower_preview(tile_position, "00ff00a0")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "ff0000a0")
		build_valid  = false
	if GameData.tower_data[build_type]["cost"] > bank_account:
		build_valid  = false

func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").free()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		new_tower.category = GameData.tower_data[build_type]["category"]
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cell(build_tile, 2, Vector2(1, 0))
		bank_account -= GameData.tower_data[build_type]["cost"]
		get_node("UI").update_bank_account()

func on_base_damage(damage):
	base_health -= damage
	var ui = get_node("UI")
	if base_health <= 0:
		ui.update_health_bar(0)
		ui.show_text_overlay("Game over!")
		await get_tree().create_timer(3.0).timeout
		ui.hide_text_overlay()
		on_quit()
	else:
		ui.update_health_bar(base_health)

func on_quit():
	emit_signal("game_finished", false)
