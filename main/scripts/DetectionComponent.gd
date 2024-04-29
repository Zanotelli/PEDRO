class_name DetectionComponent
extends Area2D

@onready var BODY : BaseEnemy = get_parent()


func _on_body_entered(body):
	if body is Player:
		BODY.PLAYER = body
		BODY.CHASE = true


func _on_body_exited(body):
	BODY.PLAYER = null
	BODY.CHASE = false
