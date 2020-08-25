extends Spatial

func _ready():
	# LOCKS AND HIDES THE MOUSE TO THE GAME SCREEN
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# PINS THE GAME TO RIGHT SIDE OF SCREEN, NOT NECESSARY BUT USEFUL TO VIEW DEBUGGER
	OS.set_window_position(Vector2(0,0))

# RELOAD SCENE WHEN BUTTON PRESSED
func _input(event):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
