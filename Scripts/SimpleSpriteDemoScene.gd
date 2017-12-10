extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var profDir=1

func _ready():
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
	
	var prof = self.get_node("Professor")
	prof.position.x+=delta*40*profDir
	if prof.position.x>1000:
		profDir=-1
		prof.animation="Left"
	if prof.position.x<100:
		profDir=1
		prof.animation="Right"
	pass