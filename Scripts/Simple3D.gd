extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ship_created = false

var n=0.0;
var ec=0;

# Called when the node enters the scene tree for the first time.
func _ready():
	createShip()
	createEnemy()
	pass # Replace with function body.

func moveEnemies(delta):
	var childs = self.get_children()
	for node in childs:		
		if node.name.left(5)=="Enemy":
			var nd = node as KinematicBody
			if nd.transform.origin.z>1:
				self.remove_child(node)
				nd.queue_free()	
			else:
				var m=nd.move_and_collide(Vector3(0,0,delta*5))
				if m!=null:
					get_tree().change_scene("Scenes/Main.tscn")				
	pass

func createShip():
	var shipPrefAb = load("res://Scenes/Prefabs/Ship.tscn")
	var shipNode:Spatial = shipPrefAb.instance()
	shipNode.transform.origin=Vector3(0,-0.4,-1)
	self.add_child(shipNode)
	
func createEnemy():
	var enemyPrefAb = load("res://Scenes/Prefabs/3DEnemy.tscn")
	var enemyNode:Spatial = enemyPrefAb.instance()
	randomize()
	var f = rand_range(-0.7,0.7)	
	enemyNode.transform.origin=Vector3(f,-0.4,-15) 
	enemyNode.name="Enemy"+str(ec)
	ec=ec+1
	self.add_child(enemyNode);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if rand_range(0,400)<9:
		createEnemy()
	
	moveEnemies(delta)
	n+=(delta/5)
	
	$Grid.get_surface_material(0).set_shader_param("dt",n);		
	pass
	
	