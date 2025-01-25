extends Control

const MAIN_MENU := preload("res://menus/main_menu/main_menu.tscn")
const PLAY_SCENE := preload("res://Map/Arena.tscn")

@onready var player_label: Label = $PlayerLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var winning_player = "Undefined"
    if GlobalWinner.winner_id == 0:
        winning_player = "Left"
    if GlobalWinner.winner_id == 1:
        winning_player = "Right"
    player_label.text = winning_player + " player won!"


func _on_replay_button_pressed() -> void:
    get_tree().change_scene_to_packed(PLAY_SCENE)


func _on_quit_button_pressed() -> void:
    get_tree().change_scene_to_packed(MAIN_MENU)
