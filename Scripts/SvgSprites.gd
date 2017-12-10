extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	self.set_process(true)    
	
	var scene = load("res://Scenes/Prefabs/SvgUFO.tscn")
	    
	for i in range(100):	
	   var node = scene.instance()
	   node.scale = Vector2(0.5,0.5)    
	   node.position.x=50+(randf() * 500)
	   node.position.y=80+(randf() * 300)
	   node.half=16
	   self.add_child(node)	
	
	
	pass


func _input(event):
	if event is InputEventScreenTouch && event.pressed:
		get_tree().change_scene("Scenes/Main.tscn")
	pass
