extends PathFollow2D

signal base_damage(damage)

var speed = 300
var hp = 1000
var damage_to_base = 21
var cash_value = 55

@onready var health_bar = get_node("HealthBar")
@onready var impact_area = get_node("Impact")
var projectile_impact = preload("res://Scenes/SupportScenes/projectile_impact.tscn")
var missile_impact = preload("res://Scenes/SupportScenes/missile_impact.tscn")

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_top_level(true)

func _physics_process(_delta):
	if progress_ratio == 1.0:
		emit_signal("base_damage", damage_to_base)
		queue_free()
	move(_delta)
	
func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(position - Vector2(32, 32))
	
func on_hit(damage, ammo_type):
	impact(ammo_type)
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		#add cash
		get_parent().get_parent().get_parent().bank_account += cash_value
		get_parent().get_parent().get_parent().get_node("UI").update_bank_account()
		on_destroy()

func impact(ammo_type):
	var x_pos = 0
	var y_pos = 0
	var new_impact
	if ammo_type == "Projectile":
		randomize()
		x_pos = (randi() % 32) - 16
		randomize()
		y_pos = (randi() % 32) - 16
		new_impact = projectile_impact.instantiate()
	else:
		new_impact = missile_impact.instantiate()
	var impact_location = Vector2(x_pos, y_pos)
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_destroy():
	get_node("CharacterBody2D").queue_free()
	await(get_tree().create_timer(0.2).timeout)
	self.queue_free() 
