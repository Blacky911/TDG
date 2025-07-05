extends CanvasLayer


@onready var hp_bar = get_node("HUD/InfoBar/H/HP")

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://Scenes/Turrets/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("00ff00a0")
	
	var range_texture = Sprite2D.new()
	range_texture.set_name("RangeIndicator")
	range_texture.position = Vector2(0, 0)
	var scaling = GameData.tower_data[tower_type]["range"]/600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://Assets/UI/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("00ff00a0")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.set_position(mouse_position)
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)

func update_tower_preview(new_position, color):
	get_node("TowerPreview").set_position(new_position)
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/RangeIndicator").modulate = Color(color)


##
## Game Controls funcs
##
func _on_pause_play_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if get_tree().is_paused():
		get_tree().paused = false
	else:
		get_tree().paused = true
	#elif get_parent().current_wave < get_parent().max_wave:
	#	get_parent().current_wave += 1
	#	get_parent().start_next_wave()


func _on_speed_up_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)

func _on_quit_pressed():
	get_parent().on_quit()

func update_health_bar(base_health):
	var hp = get_node("HUD/InfoBar/H/HP")
	var hp_bar_tween = hp.create_tween()
	hp_bar_tween.tween_property(hp, "value", base_health, 0.1)
	if base_health >= 60:
		hp.tint_progress = Color("00e000")
	elif base_health <= 60 and base_health >= 25:
		hp.tint_progress = Color("ff8000")
	else:
		hp.tint_progress = Color("e00000")

func update_bank_account():
	var bank_account = get_parent().bank_account
	get_node("HUD/InfoBar/H/Money").set("text", bank_account)

func show_text_overlay(message):
	get_node("TextOverlay").set("text", message)
	get_node("TextOverlay").set("visible", true)

func hide_text_overlay():
	get_node("TextOverlay").set("visible", false)
