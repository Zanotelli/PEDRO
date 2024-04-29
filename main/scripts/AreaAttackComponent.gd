class_name AreaAttackComponent
extends GenericAttackCompnent

@onready var area := $Area as CollisionShape2D
@export var DAMAGE_SELF : float = 0.0

func enable_explosion():
	area.set_disabled(false)
	

func _on_area_entered(area):
	if area is HitboxComponent and !(area.get_parent() is Player):
		var knockback = -get_knockback(area)
		area.on_hit(DAMAGE, knockback, DURATION)
