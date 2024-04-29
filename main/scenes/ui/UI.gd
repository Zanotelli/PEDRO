class_name UI
extends CanvasLayer

signal retry

@onready var score_label := %Score as RichTextLabel
@onready var death_label := %DeathText as RichTextLabel

@onready var game_layout := %GameLayout as VBoxContainer
@onready var restart_layout := %RestartLayout as VBoxContainer
@onready var death_layout := %DeathLayout as VBoxContainer

@onready var font : Font = load("res://assets/fonts/robtronika-font/Robtronika-4Bq8p.ttf")

var score : int = 0:
	set(new_score):
		score = new_score

func _ready():
	setup()
	
func setup():
	death_layout.set_visible(false)
	restart_layout.set_visible(false)
	game_layout.set_visible(true)
	score = 0
	

func _on_collect(collectable: Collectable):
	score += collectable.points
	collectable.queue_free()
	_update_score()
	
	
func _update_score():
	var new_score = "Score: " + str(score)
	score_label.clear()
	score_label.push_font(font, 18)
	score_label.append_text(new_score)
	
	
func handle_player_death_ui(status: Player.PlayerStatus):
	game_layout.set_visible(false)
	death_layout.set_visible(true)
	restart_layout.set_visible(true)

	score_label.clear()
	
	death_label.clear()
	death_label.newline()
	death_label.push_font(font, 30)
	death_label.append_text("YOU WERE DESTROYED")
	death_label.newline()
	death_label.newline()
	death_label.push_font(font, 15)
	death_label.append_text("Your score was: " + str(score))
	

func _on_try_again_pressed():
	retry.emit()
	setup()
