extends Node

## score to win the game
@export var victory_score: int

@onready var _score_ui: Node = $"../CanvasLayer/MatchScore"

var _is_victory_triggered = false

var _score_0_value: int
var _score_1_value: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    reset_scores()


func increase_score(player_id: int):
    if(player_id == 1):
        _score_0_value += 1
        if(_score_0_value >= victory_score):
            victory(0)
    elif(player_id == 0):
        _score_1_value += 1
        if(_score_1_value >= victory_score):
            victory(1)
    else:
        print("Out of bounds player id!")
    _score_ui.update_scores(_score_0_value, _score_1_value)


func reset_scores():
    _score_0_value = 0
    _score_1_value = 0
    _score_ui.update_scores(_score_0_value, _score_1_value)


func victory(winner_id: int):
    if(!_is_victory_triggered):
        _is_victory_triggered = true
        print("Player " + str(winner_id) + " won!")
