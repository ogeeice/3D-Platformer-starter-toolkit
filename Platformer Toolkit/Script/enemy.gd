extends KinematicBody

var velocity = Vector3()

export var gravity = -27
export var moveSpeed = 8


export var damage = 5
export var health = 100
export var score = 5
export var follow_time = 10


export (float) var distancePatrolRight = 5;
export (float) var velocityMax = 3.0; 

var sideRotation = 1;
var angleRotation = 0;  
var originPosition; 
var mesh; 

var follow = false

onready var player : Node = get_node("/root/Test/Player")


func _ready():
	originPosition = global_transform.origin; 
#	mesh = get_node("model");

func _process(delta):
	# IF NOT FOLLOWING PLAYER PATROL
	if follow == false:
		# play animation idle
		patrol(delta);
	
	# IF FOLLOWING PLAYER SET MOVEMENT DIRECTIONS TO THE PLAYERS
	if follow == true:
		var dir = (player.translation - translation).normalized()
		# play animation move
		
		
		# MOVE THE ENEMY TOWARDS THE PLAYER
		velocity.y += gravity * delta
		var tv = velocity
		tv = velocity.linear_interpolate(dir * moveSpeed,6 * delta)
		velocity.x = tv.x
		velocity.z = tv.z
		velocity = move_and_slide(velocity,Vector3(0,1,0))



func patrol(delta):
#	rotationMesh(delta); 
	
	var newPosX = sideRotation * delta * moveSpeed;
		
	global_transform.origin.x += newPosX;
	if(sideRotation == 1.0 && global_transform.origin.x > (originPosition.x+distancePatrolRight)):
		sideRotation = -1;
		angleRotation = -180;
	
	if(sideRotation == -1.0 && global_transform.origin.x < originPosition.x):
		sideRotation = 1;
		angleRotation = 180; 



#func rotationMesh(delta): 
#		if(angleRotation>0):
#			mesh.rotate_y(deg2rad(delta*500));
#			angleRotation -= delta*500;
#			if(angleRotation<=0):
#				angleRotation = 0 ;
#
#		if(angleRotation<0):
#			mesh.rotate_y(deg2rad(-delta*500));
#			angleRotation += delta*500;
#			if(angleRotation>=0):
#				angleRotation = 0 ;

# CALLED WHEN DAMAGED BY THE PLAYER
func take_damage ():
	health -= damage

	# IF HEALTH 0 THEN CALLTHE DIE FUNCTION
	if health <= 1:
		die()
	print("enemy health",health)

# CALLED WHEN ENEMY HEALTH REACHES 0 
func die ():
	player.add_score(score)
	queue_free()

# DEALS DAMAGE TO THE PLAYER
func attack ():
	player.take_damage(damage)

# IF PLAYER IN AREA FOLLOW
func _on_detect_body_entered(body):
	if body.name == "Player":
		follow = true

# IF PLAYER EXITS AREA, WAIT UNTIL SERTAIN TIME THEN RETURN IF STILL NOT IN DETECTION AREA
func _on_detect_body_exited(body):
	if body.name == "Player":
		yield(get_tree().create_timer(follow_time),"timeout")
		follow = false

# IF PLAYER IN AREA CALL THE ATTACK FUNCTION
func _on_Damage_body_entered(body):
	if body.name == "Player":
		attack()
		print("attack successful")
