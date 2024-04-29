class_name PlayerHealthBar
extends ProgressBar


@onready var timer := $Timer as Timer
@onready var damage_bar := $DamageBar as ProgressBar

var player : Player
var health_component : HealthComponent

var HEALTH : float = 0.0


func setup():
	print("cria barra")
	health_component = player.get_node("HealthComponent")
	HEALTH = health_component.HEALTH
	
	set_value(HEALTH)
	set_max(HEALTH)
	damage_bar.value = HEALTH
	damage_bar.max_value = HEALTH
	
	if !health_component.damage_recieved.is_connected(_on_health_component_damage_recieved):
		health_component.damage_recieved.connect(_on_health_component_damage_recieved)
	
	
	
func _on_timer_timeout():
	damage_bar.value = HEALTH


func _on_health_component_damage_recieved():
	var prev_health = HEALTH
	HEALTH = health_component.HEALTH
	set_value(HEALTH)
	
	if HEALTH <= 0:
		queue_free()
		
	if HEALTH < prev_health:
		timer.start()
	else:
		damage_bar.value = HEALTH
