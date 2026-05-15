extends Control

func _ready() -> void:
	Global.GameDifficulty = ""
	Global.CardPairCount = 0
	Global.load_from_file()
	change_best_score()

func change_best_score():
	for Diff : String in Global.BestTime.keys():
		var ScoreRow = get_node("Vbox/ButtonSets/BestScore/VBox/"+str(Diff))
		ScoreRow.get_child(3).text = Global.convert_seconds_to_time(Global.BestTime[Diff][0])
		ScoreRow.get_child(5).text = str(Global.BestTime[Diff][1])

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
	Global.CardPairCount = $Vbox/ButtonSets/Play/Buttons/PairCount.value
	Global.CardBackImage = $Vbox/ButtonSets/Play/CardSettings/ColorOption.get_item_icon($Vbox/ButtonSets/Play/CardSettings/ColorOption.selected)
	$AnimationPlayer.play("game")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "game":
		get_tree().change_scene_to_file("res://scenes/game_scenes/main.tscn")


func _on_best_pressed() -> void:
	$Vbox/ButtonSets/Start.visible = false
	$Vbox/ButtonSets/BestScore.visible = true


func _on_score_exit_pressed() -> void:
	$Vbox/ButtonSets/Start.visible = true
	$Vbox/ButtonSets/BestScore.visible = false
