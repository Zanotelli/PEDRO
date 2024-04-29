class_name HealthComponent
extends Node2D

signal damage_recieved

@export var MAX_HEALTH = 100.0
var HEALTH: float
var DEAD : bool = false

func _ready():
	HEALTH = MAX_HEALTH
	

func handle_damage(damage: float):
	HEALTH -= damage
	damage_recieved.emit()
	if HEALTH <= 0 and !DEAD:
		get_parent().on_death()
		DEAD = true
		


func handle_heal(heal: float):
	HEALTH += heal
	damage_recieved.emit()
	if HEALTH >= MAX_HEALTH:
		HEALTH = MAX_HEALTH


func full_heal():
	HEALTH = MAX_HEALTH
	DEAD = false
