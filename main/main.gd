class_name Main
extends Node2D


@onready var spawner : EnemySpawner = get_node("Map/EnemySpawner")
@onready var camera := $Camera as Camera2D
@onready var player_camera := %PlayerCamera as Camera2D
@onready var menu := %Menu as Menu

@export var player : Player
@export var ui : UI

@onready var player_health_resource = load("res://main/scenes/player/PlayerHealthBar.tscn")


func _ready():
	player_camera.make_current()
	if !player.item_collected.is_connected(ui._on_collect):
		player.item_collected.connect(ui._on_collect)

	if !player.player_died.is_connected(ui.handle_player_death_ui):
		player.player_died.connect(ui.handle_player_death_ui)

	if !player.player_died.is_connected(handle_player_death):
		player.player_died.connect(handle_player_death)
		
	if !ui.retry.is_connected(reestart_game):
		ui.retry.connect(reestart_game)
	
	spawner.disable()
	camera.make_current()
	#player.set_visible(false)
	ui.set_visible(false)


func handle_player_death(status: Player.PlayerStatus):
	camera.position = status.position
	camera.make_current()
	spawner.disable()


func reestart_game():
	spawner.enable()
	player_camera.make_current()
	player.initialize()
	player.set_visible(true)
	menu.set_visible(false)
	ui.set_visible(true)
	
	if ui.get_node("Control").get_node("PlayerHealthBar"):
		ui.get_node("Control").get_node("PlayerHealthBar").queue_free()
	
	var player_health : PlayerHealthBar = player_health_resource.instantiate()
	player_health.player = player
	ui.get_node("Control").add_child(player_health)
	player_health.setup()
	player_health.position = Vector2(40, 40)
	player_health.size = Vector2(300,25)



func _on_menu_start_game():
	reestart_game()
