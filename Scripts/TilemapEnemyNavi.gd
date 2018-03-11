extends Navigation2D

const SPEED = 65.0

var begin = Vector2()
var end = Vector2()
var path = []

var cnt = 100

var _lbFps = Label

func _ready():
	_lbFps = $CanvasLayer/lbFps
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	_lbFps.text=str(Engine.get_frames_per_second())
	if (path.size() > 1):
		var to_walk = delta*SPEED
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		get_node("Enemy1").position=atpos
		
		if (path.size() < 2):
			path = []
		
	if cnt > 10:
		cnt=0
		_update_path()
	else:
		cnt=cnt+1
		
	pass
	
func _update_path():
	var begin = get_node("Player").position
	var end = get_node("Enemy1").position	
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	#path.invert()
