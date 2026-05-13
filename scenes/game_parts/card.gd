extends Control

@export var CardButton : TextureButton
@export var CardImage : Texture2D

var Correct : bool = false

func _ready() -> void:
	$TextureRect.texture = CardImage

func reveal_card():
	$AnimationPlayer.play("flip")

func hide_card():
	$AnimationPlayer.play_backwards("flip")



func _on_animation_player_current_animation_changed(_name: StringName) -> void:
	if Correct == true:
		$AnimationPlayer.play("correct")
