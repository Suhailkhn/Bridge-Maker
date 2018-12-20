extends Line2D

var point
var trail_length = 20

func _ready():
	set_process(false)

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = $"../".global_position
	
	point.x += (GLOBAL.bridge_height/2) * sin(deg2rad($"../../".rotation_degrees))
	point.y -= (GLOBAL.bridge_height/2) * cos(deg2rad($"../../".rotation_degrees))
	
	add_point(point)
	
	while get_point_count() > 10:
		remove_point(0)

func start_trail():
	if GLOBAL.bridge_height != 0:
		set_process(true)
	visible = true
	set_z_index(0)

func stop_trail():
	set_process(false)
	set_points([])