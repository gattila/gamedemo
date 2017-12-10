extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speedX = 10+(100*randf())
var speedY = 10+(100*randf())

var directionX = speedX
var directionY = speedY

var half = 16

var maxx = 1024
var maxy = 600

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)
	maxx = self.get_viewport_rect().size.x
	maxy = self.get_viewport_rect().size.y - 64
	pass
		
	
func _process(delta):
   var cur_pos = self.position;
   
   cur_pos.x += directionX * delta
   cur_pos.y += directionY * delta

   self.position=cur_pos
   
   if cur_pos.x > maxx - half: directionX = speedX*-1
   if cur_pos.x<half: directionX = speedX   
   if cur_pos.y > maxy - half: directionY = speedY*-1
   if cur_pos.y<half: directionY = speedY
