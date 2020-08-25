extends Area

var velocity = Vector3()

# HEIGHT TO LIFT THE PLAYER
export var bounceheight = 50

#func _process(delta):
#	# SMOOTHENS THE SPEED AT WITH THE PLAYER BOUNCES
##	velocity.y = gravity * delta

# IF PLAYER IN AREA MOVE THE PLAYER UPWORDS USING THE BOUNCEHEIGHT VALUE
func _on_Bouncepad_body_entered(body):
	if body.name == "Player":
		body.velocity.y = bounceheight
