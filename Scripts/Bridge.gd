extends KinematicBody2D

var height = 0							# height of the region_rect of bridge
var col_height = 0						# Height of collision box

var initial_ypos = 0

var flag = 0							# Is Input completed? No
var collision = -1						# Can be -1 0 1 to siginify length of bridge is insufficient, sufficient
										# or overboard respectively

var game_over_screen_on = false

func _ready():
	set_initial_state()

func _process(delta):
	if Input.is_action_pressed('ui_select') and flag == 0 and game_over_screen_on == false:		# Don't let the height increase during rotation
		height = height + 20																	# or when the Game Over Screen is being displayed
		$Sprite.set_region_rect(Rect2(0,0,63,height))
		
		position.y = position.y - 2
		
		col_height = col_height + 2
		$CollisionShape2D.shape.set_extents(Vector2(4.725, col_height))
		
	if Input.is_action_just_released('ui_select') and flag == 0 and game_over_screen_on == false:
		$Trail.set_points([])								# Unknown reason. Fixes the bug of the trail
															# having an extra starting point 

		GLOBAL.bridge_height = $Sprite.get_region_rect().size.y * 0.2
		
		flag = 1						# Input is finished, start rotation
		$Trail.start_trail()
		
		if ($Sprite.get_region_rect().size.y * 0.2) < GLOBAL.lower_limit_for_success:
			collision = -1
		elif ($Sprite.get_region_rect().size.y * 0.2) > GLOBAL.upper_limit_for_success:
			collision = 1
		else:
			collision = 0

	if flag == 1:
		$"../".rotation_degrees += 1.5
	
	if collision == 0 or collision == 1:
		if $"../".rotation_degrees == 90:
			flag = 0							# Stop rotation
			if collision == 0:
				$"../../Music/Hit".play()
				$"../../".type_of_success()
				$"../../".comment()
				$"../../".calculate_score()
				$"../../Score".set_text("%d" % $"../../".current_score)
			else:
				$"../../Music/Overboard".play()
				if $"../../".lives == 0:
					set_process(false)					# Works for insufficient but not for overboard
					visible = false
					game_over_screen_on = true			# Another flag is used to fix it
					$"../../".game_is_over()
				else:
					$"../../".lives -= 1
			$"../../".new_turn()
	else:
		if $"../".rotation_degrees > 125:
			flag = 0
			$"../../Music/Miss".play()
			if $"../../".lives == 0:
				set_process(false)						# Works fine here
				$"../../".game_is_over()
				visible = false
			else:
				$"../../".lives -= 1
				$"../../".new_turn()


func set_initial_state():					# Reset the bridge for the next turn
	height = 0
	GLOBAL.bridge_height = 0
	col_height = 0
	position.y = initial_ypos
	flag = 0
	collision = -1
	$"../".rotation_degrees = 0
	$Sprite.set_region_rect(Rect2(0,0,63,height))
	$CollisionShape2D.shape.set_extents(Vector2(4.725, col_height))
	set_process(true)
	visible = true