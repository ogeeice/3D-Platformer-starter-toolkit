extends Area

# ALLOWS THE PLAYER TO INPUT A SCENE FROM THE INSPECTOR
export(String, FILE , ".tscn") var practice


# DETECTS IF THE PLAYER ENTERS ARE THEN CHANGES SCENE
func _on_Level_Change_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(practice)
