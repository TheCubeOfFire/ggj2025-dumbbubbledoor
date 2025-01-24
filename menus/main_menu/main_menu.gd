extends Control


@export var play_scene: PackedScene


@onready var _play_button := %PlayButton as Button
@onready var _quit_button := %QuitButton as Button


func _ready() -> void:
    _play_button.grab_focus.call_deferred()
    _quit_button.visible = OS.get_name() != "Web"


func _on_play_button_pressed() -> void:
    get_tree().change_scene_to_packed(play_scene)


func _on_credits_button_pressed() -> void:
    pass
    #get_tree().change_scene_to_file("res://menus/credits_menu.tscn")


func _on_quit_button_pressed() -> void:
    get_tree().quit()
