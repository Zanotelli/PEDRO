class_name HitboxComponent
extends Area2D

signal damage_recieved

@export var HEALT_COMPONENT : HealthComponent
@onready var parent : BaseCreature = get_parent()

func on_hit(damage: float, knockback: Vector2, stun_duration: float):
	if HEALT_COMPONENT != null:
		HEALT_COMPONENT.handle_damage(damage)
		damage_recieved.emit()
		get_parent().KNOCKBACK = knockback



func _on_hitbox_body_entered(body):
	if (body is Collectable) and (parent is Player):
		var item : Collectable = body
		var palyer : Player = parent
		palyer.item_collected.emit(item)
		HEALT_COMPONENT.handle_heal(item.heal)

