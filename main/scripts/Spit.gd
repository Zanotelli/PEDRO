class_name Spit
extends CharacterBody2D

@export var SPEED : float = 1000.0

var HIT : bool = false
var ATTACK_DIR : Vector2 = Vector2.ZERO
var ROT : float = 0

@onready var animation := $AnimationPlayer as AnimationPlayer
@onready var area := $RangedAttackComponent as RangedAttackComponent
@onready var sprites := $Sprite2D as Sprite2D

func _ready():
	animation.play("shoot")
	sprites.rotation = ROT
	

func _physics_process(delta):
	if !HIT:
		velocity = ATTACK_DIR * SPEED * delta
		move_and_slide()



func _on_ranged_attack_component_area_entered(area):
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
