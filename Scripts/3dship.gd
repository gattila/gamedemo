extends KinematicBody

var player_speed = 1
var eventPos = Vector2(0,0)

enum direction { IDLE, LEFT, RIGHT }

var fire_triggered = false
var _current_direction = direction.IDLE
var _last_fire = OS.get_unix_time()

var _direction_vectors = { direction.LEFT: Vector3(player_speed*-1,0,0), 
                           direction.RIGHT: Vector3(player_speed,0,0),
						   direction.IDLE: Vector3(0,0,0) }

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x=self.transform.origin.x
		
	if (_current_direction==direction.LEFT && x<-0.7) || (_current_direction==direction.RIGHT && x>0.7):
			_current_direction=direction.IDLE
	
	self.translate(_direction_vectors[_current_direction]*delta)	
	
	pass

func _unhandled_input(event):
	
	if event.is_action_pressed("ui_left"): _current_direction=direction.LEFT
	if event.is_action_pressed("ui_right"): _current_direction=direction.RIGHT
	
	if event.is_action_pressed("ui_cancel"): get_tree().change_scene("Scenes/Main.tscn")

	if event.is_action_released("ui_left") || event.is_action_released("ui_right") || event.is_action_released("ui_up") || event.is_action_released("ui_down"): 
		_current_direction=direction.IDLE
	
	if event is InputEventScreenTouch:
		if (event.pressed):
			eventPos=event.position
			if (eventPos.x<100): 
				get_tree().change_scene("Scenes/Main.tscn")
		else:
			_current_direction=direction.IDLE
				
	if event is InputEventScreenDrag:
		_current_direction=direction.IDLE
		if event.position.x>eventPos.x+15: _current_direction=direction.RIGHT
		if event.position.x<eventPos.x-15: _current_direction=direction.LEFT	
	pass