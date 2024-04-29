class_name Laser
extends CharacterBody2D

@export var SPEED : float = 8000.0

var EXPLODE : bool = false
var ATTACK_DIR : Vector2 = Vector2.ZERO

@onready var animation := $AnimationPlayer as AnimationPlayer
@onready var explosion_timer := $Detonator as Timer
@onready var sprites := $Sprite2D as Sprite2D
@onready var area := $AreaAttackComponent as AreaAttackComponent

func _ready():
	explosion_timer.start()
	animation.play("shoot")
	

func _physics_process(delta):
	if !EXPLODE:
		velocity = ATTACK_DIR * SPEED * delta
		move_and_slide()


func get_damage_2_self():
	return area.DAMAGE_SELF

	
func detonate():
	#area.enable_explosion()
	sprites.set_visible(true)
	EXPLODE = true
	animation.play("explode")


func _on_detonator_timeout():
	detonate()
	

func _on_collision_area_entered(area):
	if (area is HitboxComponent) and (area.get_parent() is BaseEnemy):
		detonate()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()
