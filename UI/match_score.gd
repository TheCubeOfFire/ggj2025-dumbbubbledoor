extends Control

@onready var _score_0: Label = $Score0
@onready var _score_1: Label = $Score1
@onready var game_over_label: Label = $GameOverLabel
@onready var _score_left: Node3D = $"../../ScoreLeft"
@onready var _score_right: Node3D = $"../../ScoreRight"


func update_scores(s0: int, s1: int):
    _score_0.text = str(s0)
    _score_1.text = str(s1)
    _score_left._change_score(s0)
    _score_right._change_score(s1)

func display_game_over():
    game_over_label.visible = true
