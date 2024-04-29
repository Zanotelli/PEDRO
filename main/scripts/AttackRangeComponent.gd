class_name AttackRangeComponent
extends Area2D

@onready var BODY : BaseEnemy = get_parent()


func _on_body_entered(body):
	if body is Player:
		BODY.ATTACKING = true


func _on_body_exited(body):
	BODY.ATTACKING = false
