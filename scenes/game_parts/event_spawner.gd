extends Node2D

@export var Events : Array[PackedScene]
var Difficulty : String = Global.GameDifficulty

func _ready() -> void:
	_on_event_timer_timeout()

func _on_event_timer_timeout() -> void:
	var EventInstance = Events[1].instantiate()
	add_child(EventInstance)
