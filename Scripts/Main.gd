extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_btSimpleSpriteDemo_pressed():
	get_tree().change_scene("Scenes/SimpleSpriteDemo.tscn")	
	pass 

func _on_btPhysics_pressed():
	get_tree().change_scene("Scenes/PhysicsDemo.tscn")
	pass 


func _on_btTileMap_pressed():
	get_tree().change_scene("Scenes/TileMapDemo.tscn")
	pass 


func _on_btStarRaiders_pressed():
	get_tree().change_scene("Scenes/StarRaiders.tscn")
	pass 


func _on_btSimple3D_pressed():
	get_tree().change_scene("Scenes/Simple3D.tscn")
	pass 

func _on_btnSvgSpritesDemo_pressed():
	get_tree().change_scene("Scenes/SvgSprites.tscn")
	pass 


func _on_btShaderTest_pressed():
	get_tree().change_scene("Scenes/SimpleShaderTest.tscn")
	pass 
