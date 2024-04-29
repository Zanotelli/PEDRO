class_name EnemyAttackComponent
extends GenericAttackCompnent

@onready var CREATURE : BaseCreature = get_parent()

var TARGET : HitboxComponent = null

func _process(delta):
	if CREATURE.ATTACKING and !CREATURE.ATTACK_COOLDOWN:
		attack()
		
		
func attack():
	if TARGET != null:		
		var parent = get_parent()
		var attack_dir : Vector2 = (parent.PLAYER.DIR - parent.DIR).normalized()
		var knockback = attack_dir * KNOCK_BACK_FORCE
		TARGET.on_hit(DAMAGE, knockback, DURATION)
		CREATURE.ATTACK_COOLDOWN = true
		CREATURE.attack_cooldown.start()


func _on_hitbox_area_entered(area : Area2D):
	if area.get_parent() is Player:
		TARGET = area
		CREATURE.ATTACKING = true


func _on_area_exited(area):
	CREATURE.ATTACKING = false
