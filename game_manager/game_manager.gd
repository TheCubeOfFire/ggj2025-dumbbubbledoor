extends Node

const VICTORY_SCREEN := preload("res://menus/victory_screen/victory_screen.tscn")
const START_JINGLE := preload("res://sounds/files/game-start.mp3")
const END_JINGLE := preload("res://sounds/files/game-over.mp3")

## score to win the game
@export var victory_score: int
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

## time to wait after game is over
@export var game_over_cooldown: float

@onready var _score_ui: Node = $"../CanvasLayer/MatchScore"
@onready var left_player: Player = $"../Players/LeftPlayer"
@onready var right_player: Player = $"../Players/RightPlayer"


var _is_victory_triggered = false

var _score_0_value: int
var _score_1_value: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    reset_scores()
    MusicPlayer.play_music()
    audio_stream_player.stream = START_JINGLE
    audio_stream_player.play()


func increase_score(player_id: int):
    if _is_victory_triggered:
        return
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
        audio_stream_player.stream = END_JINGLE
        audio_stream_player.play()
        _is_victory_triggered = true
        left_player.is_game_over = true
        right_player.is_game_over = true
        _score_ui.display_game_over()
        GlobalWinner.winner_id = winner_id
        var _timer = get_tree().create_timer(game_over_cooldown)
        await _timer.timeout
        get_tree().change_scene_to_packed(VICTORY_SCREEN)
