extends Area

# ROTATION SPEED
export var speed = 500

func _process(delta):
	# ROTATES THE COIN, ALOT BETTER THAN ANIMATING ROTATION
	rotation_degrees.z -= speed * delta


func _on_Jump_power_up_body_entered(body):
	if body.name == "Player": 
		body.jump_power_up()
		queue_free()
