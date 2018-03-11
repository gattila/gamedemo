extends KinematicBody2D

var player_speed = 100
var eventPos = Position2D

enum direction { IDLE, LEFT, RIGHT }
var fire_triggered = false
var _current_direction = direction.IDLE
var _last_fire = OS.get_unix_time()

var _leftDirecttion = Vector2()
var _rightDirection = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	_leftDirecttion = Vector2(-1*player_speed,0)
	_rightDirection = Vector2(player_speed,0)
	pass

func _physics_process(delta):
		
	var d = Vector2(0,0)
	
	match _current_direction:
		direction.LEFT: d=_leftDirecttion
		direction.RIGHT: d=_rightDirection
	
	var c = move_and_collide(d*delta)
	
	if fire_triggered: HandleFire()
	
	pass
	
func HandleFire():
	var timeNow = OS.get_unix_time()
	var dt = timeNow-_last_fire 
	if dt>0:
		var firePrefTab = load("res://Scenes/Prefabs/RaidersPlayerLaser.tscn")
		var node = firePrefTab.instance()
		node.position.x = self.position.x
		node.position.y = self.position.y
		node.z_index=self.z_index-1
		#node.set_z(self.get_z()-1)
		self.get_owner().add_child(node)
		
		_last_fire=timeNow
	pass

func _unhandled_input(event):
	
	if event.is_action_pressed("ui_left"): _current_direction=direction.LEFT
	if event.is_action_pressed("ui_right"): _current_direction=direction.RIGHT
	if event.is_action_pressed("ui_up"): fire_triggered=true
	if event.is_action_pressed("ui_cancel"): get_tree().change_scene("Scenes/Main.tscn")
		
	if event.is_action_released("ui_up"): fire_triggered=false
	if event.is_action_released("ui_left") || event.is_action_released("ui_right"): 
		_current_direction=direction.IDLE
	
	#print (str(event))
	
	if event is InputEventScreenTouch:
		if (event.pressed):
			eventPos=event.position
			if (eventPos.x<100): 
				get_tree().change_scene("Scenes/Main.tscn")
		else:
			_current_direction=direction.IDLE
			fire_triggered = false
	
	if event is InputEventScreenDrag:
		fire_triggered = false
		_current_direction=direction.IDLE
		if event.position.x>eventPos.x+15: _current_direction=direction.RIGHT
		if event.position.x<eventPos.x-15: _current_direction=direction.LEFT
		if event.position.y<eventPos.y-15: fire_triggered = true
	pass

func Destroy():
	$Sprite.self_modulate=Color(1,1,1,1)
	$Sprite.modulate=Color(1,1,1,1)
	pass

func Kill():
	$Anim.play("Explosion")
	pass