extends Control

@export var CardButton : TextureButton
@export var CardImage : Texture2D

func _ready() -> void:
	$TextureRect.texture = CardImage

func reveal_card():
	$AnimationPlayer.play("flip")

func hide_card():
	$AnimationPlayer.play_backwards("flip")
