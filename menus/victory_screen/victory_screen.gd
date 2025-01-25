extends Control


@onready var player_label: Label = $PlayerLabel
@onready var _play_button: Button = $ReplayButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    _play_button.grab_focus.call_deferred()
    var winning_player = "Undefined"
    if GlobalWinner.winner_id == 0:
        winning_player = "Left"
    if GlobalWinner.winner_id == 1:
        winning_player = "Right"
    player_label.text = winning_player + " player won!"


func _on_replay_button_pressed() -> void:
    get_tree().change_scene_to_file("res://Map/Arena.tscn")


func _on_quit_button_pressed() -> void:
    get_tree().change_scene_to_file("res://menus/main_menu/main_menu.tscn")
