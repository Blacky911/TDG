extends Node2D

var type
var category
var enemy_array = []
var built = false
var enemy
var is_ready = true

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[type]["range"]

func _physics_process(_delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
		if is_ready:
			fire()
	else:
		enemy = null
	
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]
	
func turn():
	get_node("Turret").look_at(enemy.position)
	
func fire():
	is_ready = false
	if category == "Projectile":
		fire_gun()
	elif category == "Missile":
		fire_missile()
	enemy.on_hit(GameData.tower_data[type]["damage"], GameData.tower_data[type]["category"])
	await(get_tree().create_timer(GameData.tower_data[type]["rof"])).timeout
	is_ready = true

func fire_gun():
	get_node("AnimationPlayer").play("Fire")

func fire_missile():
	randomize()
	var launched_missile = (randi() % 2) + 1
	if launched_missile == 1:
		get_node("AnimationPlayer").play("FireMissileOne")
	if launched_missile == 2:
		get_node("AnimationPlayer").play("FireMissileTwo")

func _on_range_body_entered(body):
	enemy_array.append(body.get_parent())

func _on_range_body_exited(body):
	enemy_array.erase(body.get_parent())
