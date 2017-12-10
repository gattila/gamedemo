extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	self.position.y-=120*delta
	if self.position.y<0:
		self_destroy()	  
	pass

func self_destroy():	
	queue_free()
	pass

func _on_RaidersPlayerLaser_body_entered( body ):	
		
	if body.get_name().left(5)=="Enemy" || body.get_name().left(5)=="Block":
		body.Kill()
		self_destroy()
		
	pass 

