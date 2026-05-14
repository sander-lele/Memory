extends Control

var Music : int = 0
var Sound : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sound = AudioServer.get_bus_index("SFX")
	Music = AudioServer.get_bus_index("Music")
	if Global.GameDifficulty == "":
		$Panel/VBoxContainer/Buttons.visible = false

func _process(delta: float) -> void:
	if visible:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _on_close_button_pressed() -> void:
	visible = false


func _on_sound_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Sound,value)


func _on_music_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Music,value)


func _on_menu_pressed() -> void:
	$AnimationPlayer.play("menu")


func _on_retry_pressed() -> void:
	$AnimationPlayer.play("retry")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match(anim_name):
		"menu":
			get_tree().change_scene_to_file("res://scenes/game_scenes/title.tscn")
		"retry":
			get_tree().reload_current_scene()
