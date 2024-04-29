class_name BaseEnemy
extends BaseCreature


@onready var PLAYER : CharacterBody2D


@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var attack_cooldown := $AttackCooldown as Timer
@onready var hit_cooldown := $InvincibilityTimer as Timer

@onready var item = load("res://main/scenes/itens/Collectable.tscn")

func movment_handler(delta):
	if !ATTACKING and PLAYER != null:
		DIR = (PLAYER.position - position).normalized()
		velocity = (DIR * SPEED * delta)
	else:
		velocity = Vector2.ZERO
	if INVINCILITY:
		velocity += KNOCKBACK


func get_points() -> int:
	return 10

func get_heal() -> int:
	return 5

func on_death() -> void:
	var item_drop : Collectable = item.instantiate()
	item_drop.points = get_points()
	item_drop.heal = get_heal()
	item_drop.type = randi_range(0,1)
	item_drop.position = global_position
	get_parent().get_parent().add_child(item_drop)
	queue_free()
	

func set_player(player: Player):
	PLAYER = player
