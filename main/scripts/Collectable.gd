class_name Collectable
extends StaticBody2D


@onready var animation := $AnimationPlayer as AnimationPlayer
@onready var sprites := $Sprite2D as Sprite2D

@export var points : int = 0
@export var type : int = 0
@export var heal : int = 0


func _process(delta):
	if type == 0:
		animation.play("parafuso")
	if type == 1:
		animation.play("porca")
