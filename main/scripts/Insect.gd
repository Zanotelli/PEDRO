class_name Insect
extends BaseEnemy

var BASE_SPEED : float = 2500.0

@onready var attack_component := $AttackComponent as EnemyAttackComponent

func _init():
	SPEED = BASE_SPEED

func _physics_process(delta):
	movment_handler(delta)
	move_and_slide()


func _process(delta):
	if DIR.x > 0:
		sprites.scale.x = -1
	elif DIR.x < 0:
		sprites.scale.x = 1
	
	if !INVINCILITY:
		if !ATTACKING:
			if velocity != Vector2.ZERO:
				animation.play("run")
			else:
				animation.stop()
		else:
			animation.play("attack")
	else:
		animation.play("hurt")



func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false


func _on_hitbox_component_damage_recieved():
	INVINCILITY = true
	hit_cooldown.start()


func _on_invincibility_timer_timeout():
	INVINCILITY = false
