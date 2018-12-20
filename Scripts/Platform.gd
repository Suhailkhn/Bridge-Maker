extends StaticBody2D

var platform_width
const platform_height = 173.333333 								# Real = 26

var platform_xpos
const platform_ypos = 500

func _ready():
	create_new_platform()

func new_platform_width():
	randomize()
	var width = (randi() % 750) + 300
	$"../".platform_region_width = width
	return width

func new_platform_posx(width):
	# Region Between x = 120 and 425
	var true_half_width = width * 0.07/2
	var lower_bound = 120 + true_half_width
	var upper_bound = 425 - true_half_width
	randomize()
	var xpos = (randi() % int(upper_bound - lower_bound)) + lower_bound
	return xpos

func create_new_platform():
	platform_width = new_platform_width()
	GLOBAL.Platform_Width = platform_width * 0.07
	
	platform_xpos = new_platform_posx(platform_width)
	GLOBAL.Platform_posX = platform_xpos
	
	GLOBAL.range_for_success()
	
	$".".position = Vector2(platform_xpos, platform_ypos)
	$Sprite.set_region_rect(Rect2(0, 0, platform_width, platform_height))
	$CollisionShape2D.shape.set_extents(Vector2(platform_width * 0.07/2, 26/2))
	
	$"../DiamondStick".position = global_position