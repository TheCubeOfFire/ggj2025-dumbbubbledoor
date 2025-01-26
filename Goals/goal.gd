extends Area3D

## id of the player defending this goal
@export var player_id: int

@onready var _game_manager: Node = $"../../../../SubViewportContainer/SubViewport/MainCamera/GameManager"
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


func _on_body_entered(body: Node3D) -> void:
	if is_instance_of(body, Arrow):
		if body.is_active:
			audio_stream_player_3d.play()
			_game_manager.increase_score(player_id)
			body.queue_free()



func _on_body_exited(body: Node3D) -> void:
	if is_instance_of(body, Arrow):
		body.is_active = true
