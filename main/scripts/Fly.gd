class_name Fly
extends BaseEnemy

var BASE_SPEED : float = 2000.0
var SPIT_HOLDER : Spit = null

@onready var spit_attack = load("res://main/scenes/projectiles/Spit.tscn")

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
		if ATTACKING:
			animation.play("attack")
			if !ATTACK_COOLDOWN:
				attack()
		else:
			animation.play("fly")
	else:
		animation.play("hurt")


func attack():
	attack_cooldown.start()
	ATTACK_COOLDOWN = true
	var spit : Spit = spit_attack.instantiate()
	
	var target_pos = (PLAYER.position - position).normalized()
	if target_pos.x >= 0:
		sprites.scale.x = -1
		spit.position = position + Vector2(15,0)
	else:
		sprites.scale.x = 1
		spit.position = position + Vector2(-15,0)
	spit.ATTACK_DIR = target_pos
	spit.ROT = Vector2(-target_pos.x, -target_pos.y).angle()
	SPIT_HOLDER = spit


func get_points() -> int:
	return 15


func _on_hitbox_component_damage_recieved():
	INVINCILITY = true
	hit_cooldown.start()


func _on_invincibility_timer_timeout():
	INVINCILITY = false


func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false


func _on_player_animation_finished(anim_name):
	if anim_name.contains("attack") and SPIT_HOLDER != null:
		get_parent().add_child(SPIT_HOLDER)
