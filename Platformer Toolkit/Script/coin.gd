extends Area

# ROTATION SPEED
export var speed = 500

# AMOUNT TO ADD TO PLAYERS SCORE
export var scoretogive = 1

func _process(delta):
	# ROTATES THE COIN, ALOT BETTER THAN ANIMATING ROTATION
	rotation_degrees.y -= speed * delta

# IF PLAYER IN AREA ADD SCORE TO EXISTING THEN DELETE
func _on_coin_body_entered(body):
	if body.name == "Player": 
		body.add_score(scoretogive)
		queue_free()
