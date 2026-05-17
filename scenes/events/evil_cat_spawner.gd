extends Node2D

var EvilCatScene = preload("res://scenes/game_parts/evil_cat.tscn")


func _on_duration_timeout() -> void:
	for cat in $Cats.get_children():
		cat.die()
	$SpawnInterval.stop()
	await get_tree().create_timer(5).timeout
	queue_free()

func _on_spawn_interval_timeout() -> void:
	var EvilCatInstance : CharacterBody2D = EvilCatScene.instantiate()
	EvilCatInstance.position = $SpawnPoints.get_child(randi_range(0,3)).position
	EvilCatInstance.speed = randi_range(180,300)
	EvilCatInstance.steer_force = randf_range(45,90)
	$Cats.add_child(EvilCatInstance)
