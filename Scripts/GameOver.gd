extends ColorRect

var scene_to_load

func _ready():
	rect_position = Vector2(450,150)
	$Score.set_text(str($"../".current_score))
	if GLOBAL.new_high_score == true:
		$HighScore.visible = true
	else:
		$HighScore.visible = false
	$Diamond/NoOfDiamonds.set_text(str($"../".diamonds_obtained))

func _process(delta):
	if rect_position.x > 0:
		rect_position.x -= 9

func _on_Retry_pressed():
	$ButtonSelect.play()
	scene_to_load = "res://Scenes/Game.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	GLOBAL.playback_position = $"../Music/Soundtrack".get_playback_position()
	get_tree().change_scene(scene_to_load)


func _on_Home_pressed():
	$ButtonSelect.play()
	scene_to_load = "res://Scenes/StartScreen.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()