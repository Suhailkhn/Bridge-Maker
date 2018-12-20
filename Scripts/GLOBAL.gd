extends Node

var viewport_scale
var viewport

var main_menu_playback_position = 0.0

var Platform_Width
var Platform_posX
var bridge_height

var lower_limit_for_success
var upper_limit_for_success

var high_score = 0
var new_high_score = false
var diamonds = 0

var playback_position = 0.0

func _ready():
	viewport = get_node("/root").get_children()[2].get_viewport_rect().size
	viewport_scale = 450/viewport.x

func range_for_success():
	lower_limit_for_success = Platform_posX - (Platform_Width/2) - 47
	upper_limit_for_success = Platform_posX + (Platform_Width/2) - 47