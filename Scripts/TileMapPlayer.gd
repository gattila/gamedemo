extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


var player_speed = 90
var eventPos = Position2D

enum direction { UP, DOWN, LEFT, RIGHT }
var _current_direction = direction.UP
var sprite = AnimatedSprite
var enemyObject = Node
var exitObject = Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	sprite = self.get_node("PlayerSprite")
	enemyObject = self.get_owner().get_node("Enemy1")
	exitObject = self.get_owner().get_node("Exit")
	pass
	
func _physics_process(delta):	
		
	var d = Vector2()
		
	match _current_direction:
		direction.LEFT: d.x=-1*player_speed*delta
		direction.RIGHT: d.x=player_speed*delta
		direction.UP: d.y=-1*player_speed*delta
		direction.DOWN: d.y=player_speed*delta
	
	var c = move_and_collide(d)
		
	if c!=null && (c.collider == exitObject || c.collider == enemyObject):
		get_tree().change_scene("Scenes/Main.tscn")
	
	pass

func ChangeDirection(newdirection):
	if newdirection!=_current_direction:
		match newdirection:
			direction.LEFT: sprite.animation="Left"
			direction.RIGHT: sprite.animation="Right"
			direction.UP: sprite.animation="Up"
			direction.DOWN: sprite.animation="Down"
		
	_current_direction=newdirection	
	pass

func _input(event):
	
	if event.is_action_pressed("ui_left"): ChangeDirection(direction.LEFT)
	if event.is_action_pressed("ui_right"): ChangeDirection(direction.RIGHT)
	if event.is_action_pressed("ui_up"): ChangeDirection(direction.UP)
	if event.is_action_pressed("ui_down"): ChangeDirection(direction.DOWN)
	
	if event is InputEventScreenTouch:
		if (event.pressed):
			eventPos=event.position
		else:
			var ax=abs(eventPos.x - event.position.x)
			var ay=abs(eventPos.y - event.position.y)
			if ax>5 || ay>5:
				if ax>ay:
					if eventPos.x<event.position.x:
						ChangeDirection(direction.RIGHT)
					else:
						ChangeDirection(direction.LEFT)
				else:					
					if eventPos.y<event.position.y:
						ChangeDirection(direction.DOWN)
					else:
						ChangeDirection(direction.UP)
	pass