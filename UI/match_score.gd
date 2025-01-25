extends Control

@onready var _score_0: Label = $Score0
@onready var _score_1: Label = $Score1



func update_scores(s0: int, s1: int):
    _score_0.text = str(s0)
    _score_1.text = str(s1)
