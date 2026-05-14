extends Control

func _ready() -> void:
	Global.GameDifficulty = ""
	Global.CardPairCount = 0

func _on_play_button_pressed() -> void:
	$Vbox/ButtonSets/Start.visible = false
	$Vbox/ButtonSets/Play.visible = true


func _on_settings_pressed() -> void:
	$Settings.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	$Vbox/ButtonSets/Start.visible = true
	$Vbox/ButtonSets/Play.visible = false




func _on_difficulty_pressed(source: BaseButton) -> void:
	Global.GameDifficulty = source.name
	Global.CardPairCount = $Vbox/ButtonSets/Play/PairCount.value
	$AnimationPlayer.play("game")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "game":
		get_tree().change_scene_to_file("res://scenes/game_scenes/main.tscn")
