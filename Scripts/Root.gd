extends Control

var high_score = 0
var current_score = 0 setget _set_current_score
var diamonds_obtained = 0
var total_diamonds = 0

var success_type = -2		# Can be -1 for epic
								# 0 for perfect
								# 1 for normal

# Variables to determine the type of success
var perfect_lower
var perfect_upper
var epic_lower
var epic_upper

var platform_region_width			# To determine the points obtained

var lives = 3 setget _set_remaining_lives

var game_over_screen
var game_over = preload("res://Scenes/GameOver.tscn")

var epic_comment = ["Epic", "Savage", "Legend", "Close!"]
var comment_index					# Random index to choose a comment from the array

func _ready():
	$Music/Soundtrack.play(GLOBAL.playback_position)

func new_turn():
	$Node2D/Bridge/Trail.stop_trail()
	$Node2D/Bridge.set_initial_state()
	$Platform.create_new_platform()

func calculate_score():
	if GLOBAL.Platform_posX <= 450 * 0.6:
		if platform_region_width >= 750:
			if success_type == -1:
				current_score += 10
			elif success_type == 0:
				current_score += 10
			else:
				current_score += 5
		
		elif platform_region_width >= 500:
			if success_type == -1:
				current_score += 20
			elif success_type == 0:
				current_score += 15
			else:
				current_score += 10
		
		else:
			if success_type == -1:
				current_score += 30
			elif success_type == 0:
				current_score += 25
			else:
				current_score += 20
	
	else:
		if platform_region_width >= 750:
			if success_type == -1:
				current_score += 20
			elif success_type == 0:
				current_score += 15
			else:
				current_score += 10
		
		elif platform_region_width >= 500:
			if success_type == -1:
				current_score += 30
			elif success_type == 0:
				current_score += 25
			else:
				current_score += 20
		else:
			if success_type == -1:
				current_score += 40
			elif success_type == 0:
				current_score += 35
			else:
				current_score += 30



func type_of_success():
	perfect_lower = GLOBAL.Platform_posX - (GLOBAL.Platform_Width * 0.05) - 47
	perfect_upper = GLOBAL.Platform_posX + (GLOBAL.Platform_Width * 0.05) - 47
	
	if GLOBAL.bridge_height >= perfect_lower and GLOBAL.bridge_height <= perfect_upper:
		success_type = 0
		return
	
	epic_lower = GLOBAL.Platform_posX - (GLOBAL.Platform_Width / 2) - 47
	epic_upper = epic_lower + (GLOBAL.Platform_Width * 0.1)
	
	if GLOBAL.bridge_height >= epic_lower and GLOBAL.bridge_height <= epic_upper:
		success_type = -1
		return
	
	success_type = 1
	return

#Not working for unknown reason
func _set_current_score(new_value):
	current_score = new_value
	$Score.set_text("%d" % new_value)

func _set_remaining_lives(new_value):
	lives = new_value
	$Heart/Lives.set_text("%d" % new_value)


func game_is_over():
	if SETTINGS.get_setting("score", "high_score") < current_score:
		GLOBAL.new_high_score = true
		SETTINGS.set_setting("score", "high_score", current_score)
	else:
		GLOBAL.new_high_score = false
	if SETTINGS.get_setting("diamonds", "total_diamonds") == null:
		total_diamonds = diamonds_obtained
	else:
		total_diamonds = SETTINGS.get_setting("diamonds", "total_diamonds") + diamonds_obtained
	SETTINGS.set_setting("diamonds", "total_diamonds", total_diamonds)
	game_over_screen = game_over.instance()
	add_child(game_over_screen)

func comment():
	if success_type == -1:
		randomize()
		comment_index = randi() % 4
		$Comment.set_text(epic_comment[comment_index])
		$Comment.visible = true
		$Diamond.visible = false
		$Comment/AnimationPlayer.play("Grow_and_Move")
	elif success_type == 0:
		$Comment.set_text("Perfect")
		$Comment.visible = true
		$Diamond.visible = true
		$Comment/AnimationPlayer.play("Grow_and_Move")
		diamonds_obtained += 1
	else:
		pass



func _on_AnimationPlayer_animation_finished(anim_name):
	$Comment.visible = false
	$Diamond.visible = false