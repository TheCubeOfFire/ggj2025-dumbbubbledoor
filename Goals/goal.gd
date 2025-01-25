extends Area3D

## id of the player defending this goal
@export var player_id: int

@onready var _game_manager: Node = $"../../GameManager"


func _on_body_entered(body: Node3D) -> void:
    if is_instance_of(body, Arrow):
        if body.is_active:
            _game_manager.increase_score(player_id)
            body.queue_free()



func _on_body_exited(body: Node3D) -> void:
    if is_instance_of(body, Arrow):
        body.is_active = true
