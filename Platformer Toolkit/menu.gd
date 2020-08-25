extends Control


# CHANGES SCENE
func _on_Button_pressed():
	get_tree().change_scene('res://Scene/Test.tscn')

# CLOSES SCENE ON BUTTON PRESSED
func _on_Button2_pressed():
	get_tree().quit()
