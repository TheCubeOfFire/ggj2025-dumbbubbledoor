extends Node3D

@onready var game_over_label: Label = $CanvasLayer/GameOverLabel
@onready var _score_left: Node3D = $ScoreLeft
@onready var _score_right: Node3D = $ScoreRight


func update_scores(s0: int, s1: int):
    _score_left._change_score(s0)
    _score_right._change_score(s1)
    

func display_game_over():
    game_over_label.visible = true
