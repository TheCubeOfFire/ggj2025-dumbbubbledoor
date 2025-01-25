class_name Player
extends Node3D


@export var controller_index := -1
@export var flipped := false

@export_range(0, 100, 0.1, "suffix:deg/s") var angular_speed := 80
@export_range(0, 2 * PI, 1, "radians_as_degrees") var angle_limit := deg_to_rad(80)


func _physics_process(delta: float) -> void:
    if controller_index < 0 && controller_index >= InputManager.get_player_count():
        return

    var up_action := InputManager.InputActionType.ANGLE_DOWN if flipped else InputManager.InputActionType.ANGLE_UP
    var down_action := InputManager.InputActionType.ANGLE_UP if flipped else InputManager.InputActionType.ANGLE_DOWN

    var angle_input := InputManager.get_axis_for_player(controller_index, down_action, up_action)
    rotation.y += angle_input * deg_to_rad(angular_speed) * delta

    if flipped:
        rotation.y = clamp(wrap(rotation.y, 0, 2 * PI), PI - angle_limit, PI + angle_limit)
    else:
        rotation.y = clamp(wrap(rotation.y, -PI, PI), -angle_limit, angle_limit)
