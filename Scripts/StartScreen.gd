extends Node2D

#var number = (SETTINGS.get_setting("diamonds", "total_diamonds"))
func _ready():
	$Music.play(GLOBAL.playback_position)
	$Score.set_text(str(SETTINGS.get_setting("score", "high_score")))
	#$TotalDiamonds.set_text("%d" % number)
	$TotalDiamonds.set_text(str(SETTINGS.get_setting("diamonds", "total_diamonds")))

func _on_FadeIn_fade_finished():
	GLOBAL.playback_position = $Music.get_playback_position()
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Play_pressed():
	$ButtonSelect.play()
	$FadeIn.show()
	$"FadeIn".fade_in()


func _on_Quit_pressed():
	get_tree().quit()