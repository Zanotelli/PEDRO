class_name GenericAttackCompnent
extends Node

@export var DAMAGE : float
@export var KNOCK_BACK_FORCE : float
@export var DURATION : float


func get_knockback(area: Area2D) -> Vector2:
		var attack_dir : Vector2 = (get_parent().position - area.position).normalized()
		return attack_dir * KNOCK_BACK_FORCE
