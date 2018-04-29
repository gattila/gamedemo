extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var _lbFps = Label

func _ready():
	_lbFps=$lbFps
	pass
	
func _input(event):
	_lbFps.text=str(Engine.get_frames_per_second())
	if event is InputEventScreenTouch && event.pressed:
		get_tree().change_scene("Scenes/Main.tscn")
	pass
