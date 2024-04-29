class_name RangedAttackComponent
extends GenericAttackCompnent

var ATTACK_DIR : Vector2 = Vector2.ZERO

func _on_area_entered(area):
	if area is HitboxComponent:
		var knockback = get_knockback(area)
		area.on_hit(DAMAGE, knockback, DURATION)
