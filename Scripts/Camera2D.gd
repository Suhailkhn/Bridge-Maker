extends Camera2D

func _ready():
	set_zoom(get_zoom() * GLOBAL.viewport_scale)

