extends Area

# ROTATION SPEED
export var speed = 500

func _process(delta):
	# ROTATES THE COIN, ALOT BETTER THAN ANIMATING ROTATION
	rotation_degrees.y -= speed * delta


func _on_Speed_power_up_body_entered(body):
	if body.name == "Player": 
		body.speed_power_up()
		queue_free()
