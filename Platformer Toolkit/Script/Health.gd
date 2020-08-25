extends Area


export var amount = 20
 
# BOBBING
onready var startYPos = translation.y
export var bobHeight  = 1.0
export var bobSpeed = 1.0
var bobbingUp  = true

func _process (delta):
# MOVE US UP OR DOWN
	translation.y += (bobSpeed if bobbingUp else -bobSpeed) * delta
	
	# IF AT THE TOP, START MOVING DOWNWARDS
	if bobbingUp and translation.y > startYPos + bobHeight:
		bobbingUp = false
	# IF AT THE BOTTOM, START MOVING UP
	elif !bobbingUp and translation.y < startYPos:
		bobbingUp = true


# IF PLAYER IS IN AREA ADD HEALTH TO HIS EXISTING THEN DELETE
func _on_Health_body_entered(body):
	if body.name == "Player":
		body.add_health(amount)
		queue_free()
