extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var profDir=1

var _lbFps = Label

func _ready():
	
	_lbFps=$lbFps
	
	self.set_process(true)    
	
	var scene = load("res://Scenes/Prefabs/ball.tscn")
	    
	for i in range(100):	
	   var node = scene.instance()    
	   node.position.x=50+(randf() * 500)
	   node.position.y=80+(randf() * 300)
	   self.add_child(node)	
	pass
	
func _input(event):
	if event is InputEventScreenTouch && event.pressed:
		get_tree().change_scene("Scenes/Main.tscn")
	pass

	
func _process(delta):
	_lbFps.text=str(Engine.get_frames_per_second())
	var prof = self.get_node("Professor")
	prof.position.x+=delta*40*profDir
	if prof.position.x>1000:
		profDir=-1
		prof.animation="Left"
	if prof.position.x<100:
		profDir=1
		prof.animation="Right"
	pass