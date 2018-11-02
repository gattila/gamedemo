extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	self.position.y+=300*delta
	if self.position.y>600:
		self_destroy()
	pass

func self_destroy():
	queue_free()
	pass

func _on_RaidersEnemyLaser_body_entered( body ):
		
	if body.get_name()=="RaidersPlayer" || body.get_name().left(5)=="Block":
		body.Kill()
		self_destroy()
	pass 
