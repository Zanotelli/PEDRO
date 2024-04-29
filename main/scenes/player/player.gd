class_name Player
extends BaseCreature

signal item_collected(collectable: Collectable)
signal player_died(staus: PlayerStatus)

class PlayerStatus:
	var points : int
	var position : Vector2

var BASE_SPEED : float = 5000.0
var LASER_COOLDOWN : bool = false
var LASER_HOLDER : Laser = null

var SEN_45 = pow(2, 1/2)/2

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var hit_cooldown_timer := $HitCooldown as Timer
@onready var attack_cooldown_timer := $AttackCooldown as Timer
@onready var laser_cooldown_timer := $LaserCooldown as Timer
@onready var attack := $Attack as PlayerAttackComponent

@export var camera : Camera2D
@export var health : HealthComponent

@onready var laser_beam = load("res://main/scenes/projectiles/Laser.tscn")


func _ready():
	SPEED = BASE_SPEED
	
func _physics_process(delta):
	if IS_ALIVE:
		movment_handler(delta)
		attack_handler()
		move_and_slide()
	

func _process(delta):
	animation_handler()	
		

func movment_handler(delta):
		DIR = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		velocity = DIR * SPEED * delta
		if INVINCILITY:
			velocity -= KNOCKBACK


func animation_handler():	
	if !ATTACKING and IS_ALIVE:
		if DIR.x != 0:
			sprites.scale.x = -DIR.x
		if DIR != Vector2.ZERO:
			animation.play("walking_side")
		else:
			animation.play("idle")
			

func attack_handler():	
	if Input.is_action_just_pressed("attack1") and !ATTACK_COOLDOWN:
		attack1()
	if Input.is_action_just_pressed("attack2") and !LASER_COOLDOWN:
		attack2()
		

func attack1():
	ATTACKING = true
	SPEED = SPEED * 0.1
	ATTACK_COOLDOWN = true
	var _pos = get_attack_direction()
	if _pos == 1:
		animation.play("attack_up")
		sprites.scale.x = -1
	elif _pos == 2:
		animation.play("attack_left")
		sprites.scale.x = 1
	elif _pos == 3:
		animation.play("attack_right")
		sprites.scale.x = -1
	elif _pos == 4:
		animation.play("attack_down")
		sprites.scale.x = -1
	attack_cooldown_timer.set_wait_time(animation.current_animation_length)
	attack_cooldown_timer.start()
	attack.enable_attack()


func attack2():
	ATTACKING = true
	LASER_COOLDOWN = true
	SPEED = 0
	var laser : Laser = laser_beam.instantiate()
	
	var angle = get_attack_direction()
	var _pos = (camera.get_global_mouse_position() - position).normalized()
	if angle == 4:
		animation.play("laser_attack_down")
		sprites.scale.x = 1
		laser.position = position + Vector2(20,10)
	else:
		if _pos.x >= 0:
			animation.play("laser_attack")
			sprites.scale.x = -1
			laser.position = position + Vector2(40,0)
		else:
			animation.play("laser_attack")
			sprites.scale.x = 1
			laser.position = position + Vector2(-40,0)
	
	laser.ATTACK_DIR = _pos
	LASER_HOLDER = laser
	laser_cooldown_timer.start()


func get_attack_direction():
	var attack_dir = camera.get_global_mouse_position() - position
	if attack_dir.y < SEN_45 * attack_dir.x and attack_dir.y < -SEN_45 * attack_dir.x:
		return 1 # UP
	elif attack_dir.y >= SEN_45 * attack_dir.x and attack_dir.y < -SEN_45 * attack_dir.x:
		return 2 # LEFT
	elif attack_dir.y < SEN_45 * attack_dir.x and attack_dir.y >= -SEN_45 * attack_dir.x:
		return 3 # RIGHT
	elif attack_dir.y >= SEN_45 * attack_dir.x and attack_dir.y >= -SEN_45 * attack_dir.x:
		return 4 # DOWN
	return 0


func on_death():
	var status : PlayerStatus = PlayerStatus.new()
	status.position = position
	player_died.emit(status)
	IS_ALIVE = false
	animation.play("death")
	
# Signals

func _on_animation_player_animation_finished(anim_name):
	if anim_name.contains("attack"):
		ATTACKING = false
		attack.disable_attack()
		SPEED = BASE_SPEED
		if anim_name.contains("laser"):
			get_parent().add_child(LASER_HOLDER)
			health.handle_damage(LASER_HOLDER.get_damage_2_self())
	elif anim_name == "death":
		animation.play("dead")


func _on_hit_cooldown_timeout():
	INVINCILITY = false
	sprites.set_modulate(Color(1,1, 1, 1))


func _on_hitbox_damage_recieved():
	INVINCILITY = true
	hit_cooldown_timer.start()
	sprites.set_modulate(Color(218,104, 97, 1))


func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false


func _on_laser_cooldown_timeout():
	LASER_COOLDOWN = false
	

func _on_health_timeout_timeout():
	health.handle_damage(1)


func initialize():
	position = Vector2.ZERO
	IS_ALIVE = true
	health.full_heal()
