extends Control

@onready var _score_0: Label = $Score0
@onready var _score_1: Label = $Score1
@onready var game_over_label: Label = $GameOverLabel



func update_scores(s0: int, s1: int):
    _score_0.text = str(s0)
    _score_1.text = str(s1)


func display_game_over():
    game_over_label.visible = true
