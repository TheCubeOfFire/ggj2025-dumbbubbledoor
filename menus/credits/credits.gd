extends Control


@onready var _play_button: Button = $Button


func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://menus/main_menu/main_menu.tscn")


func _ready() -> void:
    _play_button.grab_focus.call_deferred()
