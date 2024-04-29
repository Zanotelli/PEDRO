class_name EnemySpawner
extends Node2D

@export var SPAWNS : Array[SpawnInfo] = []
@export var ENABLED : bool = true

@onready var PLAYER = get_parent().get_parent().get_node("player")

var time = 0


func _on_timer_timeout():
	if PLAYER != null and ENABLED:
		time += 1
		var enemy_spawns : Array[SpawnInfo] = SPAWNS
		for spawner in enemy_spawns:
			if (time >= spawner.time_start):
				if spawner.spawn_delay_counter < spawner.enemy_spawn_delay:
					spawner.spawn_delay_counter += 1
				else:
					spawner.spawn_delay_counter = 0
					var enemy_src = load(str(spawner.enemy.resource_path))
					var count = 0
					while count < spawner.enemy_num:
						var enemy : BaseEnemy = enemy_src.instantiate()
						enemy.set_player(PLAYER)
						enemy.global_position = get_spawn_position()
						get_parent().add_child(enemy)
						count += 1


func get_spawn_position():
	var vpr : Vector2 = get_viewport_rect().size * randf_range(1, 1.2)
	var rand_pos = randi_range(1,4)
	if rand_pos == 1:
		return Vector2(PLAYER.global_position.x - vpr.x/4, PLAYER.global_position.y - vpr.y/4)
	elif rand_pos == 2:
		return Vector2(PLAYER.global_position.x + vpr.x/4, PLAYER.global_position.y - vpr.y/4)
	elif rand_pos == 3:
		return Vector2(PLAYER.global_position.x - vpr.x/4, PLAYER.global_position.y + vpr.y/4)
	elif rand_pos == 4:
		return Vector2(PLAYER.global_position.x + vpr.x/4, PLAYER.global_position.y + vpr.y/4)
	return Vector2.ZERO
	

func enable():
	ENABLED = true
	time = 0
	for n in get_parent().get_children():
		if n is BaseEnemy:
			remove_child(n)
			n.queue_free()

func disable():
	ENABLED = false
