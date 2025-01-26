extends Node3D


var _players: Array[Player] = []

@onready var _player_container := $SubViewportContainer/SubViewport/Players as Node3D


func _ready() -> void:
    _init_players()
    _init_controllers()


func _init_players() -> void:
    var player_index := 0

    for child_node in _player_container.get_children():
        if not is_instance_of(child_node, Player):
            continue

        var player := child_node as Player
        if player_index < InputManager.get_player_count():
            player.controller_index = player_index
        _players.append(player)

        player_index += 1


func _init_controllers() -> void:
    # Assign default controllers if not mapped (e.g. if not started from menu)
    for controller_index in InputManager.get_player_count():
        if InputManager.get_player_input(controller_index).is_valid():
            continue

        if controller_index == 0:
            InputManager.set_player_input(controller_index, InputManager.InputControllerData.new(
                InputManager.InputControllerType.INPUT_CONTROLLER_TYPE_KEYBOARD,
                0
            ))
        else:
            InputManager.set_player_input(controller_index, InputManager.InputControllerData.new(
                InputManager.InputControllerType.INPUT_CONTROLLER_TYPE_GAMEPAD,
                controller_index - 1
            ))
