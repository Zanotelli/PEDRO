class_name PlayerAttackComponent
extends Area2D

@export var DAMAGE : float
@export var KNOCK_BACK_FORCE : float
@export var DURATION : float

@onready var PLAYER : Player = get_parent()
@onready var attack_area := $AttackArea as CollisionShape2D


func _on_area_entered(area):
	var parent = area.get_parent()
	if parent is BaseEnemy:
		var target : HitboxComponent = area
		PLAYER.ATTACKING = true
		
		var attack_dir : Vector2 = (PLAYER.DIR - parent.DIR).normalized()
		var knockback = attack_dir * KNOCK_BACK_FORCE
		
		target.on_hit(DAMAGE, knockback, DURATION)
		PLAYER.ATTACK_COOLDOWN = true
		PLAYER.attack_cooldown_timer.start()


func enable_attack():
	set_monitoring(true)


func disable_attack():
	set_monitoring(false)
