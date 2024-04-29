class_name BaseCreature
extends CharacterBody2D

@export var IS_ALIVE : bool = true
var DIR : Vector2 = Vector2.ZERO
var KNOCKBACK : Vector2 = Vector2.ZERO
var SPEED : float = 0
var INVINCILITY : bool = false
var ATTACKING : bool = false
var ATTACK_COOLDOWN : bool = false


func on_death():
	get_parent().queue_free()
	print(get_parent().name + " just died")
