class_name Player
extends Node3D


@export var controller_index := -1
@export var flipped := false

@export_range(0, 100, 0.1, "suffix:deg/s") var angular_speed := 80
@export_range(0, 2 * PI, 1, "radians_as_degrees") var angle_limit := deg_to_rad(80)


var _default_rotation := PI if flipped else 0.0
var _current_rotation := 0.0

@onready var _direction_pivot := $DirectionPivot as Marker3D


func _ready() -> void:
    _direction_pivot.rotation.y = _default_rotation


func _physics_process(_delta: float) -> void:
    if controller_index < 0 && controller_index >= InputManager.get_player_count():
        return

    _update_player_rotation()


func _update_player_rotation() -> void:
    var up_action := InputManager.InputActionType.ANGLE_DOWN if flipped else InputManager.InputActionType.ANGLE_UP
    var down_action := InputManager.InputActionType.ANGLE_UP if flipped else InputManager.InputActionType.ANGLE_DOWN

    var angle_input := InputManager.get_axis_for_player(controller_index, down_action, up_action)
    _current_rotation += angle_input * deg_to_rad(angular_speed) * get_physics_process_delta_time()
    _current_rotation = clampf(_current_rotation, -angle_limit, angle_limit)

    _direction_pivot.rotation.y = _default_rotation + _current_rotation
