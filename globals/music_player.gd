extends AudioStreamPlayer


const music = preload("res://sounds/files/game-music-loop-6-144641.mp3")

func play_music():
    if stream == music:
        return
        
    stream = music
    play()
