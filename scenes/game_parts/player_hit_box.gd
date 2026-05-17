extends Area2D

signal end_game

var Hp : int = 20

func _process(_delta: float) -> void:
	position = get_global_mouse_position()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("evil_cat"):
		Hp -= 1
		$AnimationPlayer.play("hit")
	Hp = clamp(Hp,0,20)
	if Hp == 0:
		$CollisionShape2D.set_deferred("disabled",true)
		emit_signal("end_game")
