class_name Menu
extends Control

signal start_game

@onready var title_label := %Title as RichTextLabel
@onready var tutorial_label := %Tutorial as RichTextLabel

@onready var font : Font = load("res://assets/fonts/robtronika-font/Robtronika-4Bq8p.ttf")

func _ready():
	title_label.clear()
	title_label.push_font(font, 45)
	title_label.append_text("P.E.D.R.0")
	title_label.newline()
	
	tutorial_label.clear()
	tutorial_label.push_font(font, 10)
	tutorial_label.append_text("Movement: W/A/S/D")
	tutorial_label.newline()
	tutorial_label.append_text("Attack: M1")
	tutorial_label.newline()
	tutorial_label.append_text("Laser: M2")
	tutorial_label.newline()
	

func _on_button_button_down():
	start_game.emit()


