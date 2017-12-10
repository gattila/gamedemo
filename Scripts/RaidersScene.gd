extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var _enemySpeed = 40
var _enemyDirection=_enemySpeed
var _last_enemy_fire = OS.get_unix_time()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	
	var enemyPrefTab = load("res://Scenes/Prefabs/RaidersEnemy.tscn")
	var blockPrefTab = load("res://Scenes/Prefabs/RaidersBlock.tscn")
	    
	var n = 1
	
	for i in range(16):
		for j in range(6):
	   		var node = enemyPrefTab.instance()    
	   		node.position.x=32+i*40
	   		node.position.y=32+j*40
	   		node.set_name("Enemy"+str(n))
	   		n=n+1
	   		self.add_child(node)	
	
	for i in range(4):
		for j in range(32):
			for k in range(3):
	   			var node = blockPrefTab.instance()    
	   			node.position.x=45+(i*250)+(j*6)
	   			node.position.y=450+(k*26)
	   			node.set_name("Block"+str(n))
	   			n=n+1
	   			self.add_child(node)	
		
	
	pass

func _process(delta):
	var timeNow = OS.get_unix_time()
	moveEnemies(delta)
	
	var dt = timeNow-_last_enemy_fire 
	if dt>0:
		enemyFire()
		_last_enemy_fire=timeNow
	pass

func enemyFire():
	
	var lowestEnemies={}
	var childs = self.get_children()
	for node in childs:
		if node.get_name().left(5)=="Enemy":
			var nx = node.position.x
			if !lowestEnemies.has(nx) || lowestEnemies[nx].position.y<node.position.y:
					lowestEnemies[nx]=node
	
	if lowestEnemies.size()>0:	
		
		var kx = [0,0,0]
		for i in range(3):
			var col = randi()%lowestEnemies.size()
			kx[i]=lowestEnemies.keys()[col]
		
		var playerX = $RaidersPlayer.position.x
			
		var k=kx[0]
		for i in range(3):
		  if abs(kx[i]-playerX)<abs(k-playerX):
		     k=kx[i]
		
		var shooter = lowestEnemies[k]
		var firePrefTab = load("res://Scenes/Prefabs/RaidersEnemyLaser.tscn")
		var node = firePrefTab.instance()
		node.position.x = shooter.position.x
		node.position.y = shooter.position.y
		node.set_z(self.get_z()-1)
		shooter.get_parent().add_child(node)	    
	pass

func moveEnemies(delta):
	var maxX = 0
	var minX = 1025
	var maxY = 0
	
	var childs = self.get_children()
	for node in childs:
		if node.get_name().left(5)=="Enemy":
			if node.position.x<minX: 
				minX=node.position.x
			if node.position.x>maxX: 
				maxX=node.position.x
		
	minX-=16
	maxX+=16
	maxY+=16
			
	
	var dx=_enemyDirection*delta
	var dy=0
	
	if minX+dx<0: 
		_enemyDirection=_enemySpeed
		dy=8
		
	if maxX+dx>1024: 
		_enemyDirection=-1*_enemySpeed
		dy=8
	
	dx=_enemyDirection*delta
	
	
	for node in childs:
		if node.get_name().left(5)=="Enemy":
			node.position.x+=dx
			node.position.y+=dy
	


