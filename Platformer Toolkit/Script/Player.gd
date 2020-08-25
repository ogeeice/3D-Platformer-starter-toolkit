extends KinematicBody

var direction = Vector3()
var velocity = Vector3()

# PLAYER MOVEMENT VARIABLES
export var gravity = -27
export var walk_speed = 17
export var powerup_speed = 25
export var speed_boost_time = 10

# PLAYER HEALTH VARIABLES
export var MAX_HEALTH = 100
export var MIN_HEALTH = 0
export var CURRENT_HEALTH = 100
export var damage = 5
onready var lifebar = $Control/life

# SCORE VARIABLES
onready var score =  0
onready var score_displayer = $Control/coin_amount
onready var Powerup = $Control/Powerup

# MOUSE VARIABLES
export var MOUSE_SENSITIVITY = 0.3
onready var head = $head
onready var camera = $head/Camera_Bone/Kamera

onready var body = get_node("player_mesh")

# DOUBLE JUMP VARIABLES
export var double_jump = false
export var jump_height = 17
export var powerup_jump = 25
var powerup = false
export var jump_boost_time = 10
var jump_num = 0

func _input(event):
	# MOUSE ROTATION USING THE PIVOT JOINT AS HEAD
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY
		head.rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY
		head.rotation_degrees.x = clamp(head.rotation_degrees.x,-70,70)

func _process(delta):
	# PASSES THE LIFE STATS TO THE PROGRESS BAR
	lifebar.value = CURRENT_HEALTH
	
	if powerup == false:
		Powerup.text = ""
	
	# PASSES THE SCORE AMOUNT TO LABEL
	score_displayer.text = str(score)

	# PLAYER MOVEMENT LOGIC
	direction = Vector3()
	var top = $head/Camera_Bone/Kamera.get_global_transform().basis
	if Input.is_action_pressed("forward"):
		direction -= top.z
	
	if Input.is_action_pressed("backward"):
		direction += top.z
	
	if Input.is_action_pressed("left"):
		direction -= top.x
	
	if Input.is_action_pressed("right"):
		direction += top.x
	
	direction = direction.normalized()
	velocity.y += gravity * delta
	var tv = velocity
	tv = velocity.linear_interpolate(direction * walk_speed,6 * delta)
	velocity.x = tv.x
	velocity.z = tv.z
	
	velocity = move_and_slide(velocity,Vector3(0,1,0))
	
	# JUMP LOGIC BELOW
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		# FIRST JUMP LOGIC BELOW SCRIPT IF DOUBLE JUMP ENALED FROM INSPECTOR
		if double_jump == true:
			if jump_num == 0:
				velocity.y = jump_height
				jump_num = 0
		# JUMP LOGIC BELOW SCRIPT IF SINGLE JUMP DISABLED FROM INSPECTOR
		if double_jump == false:
			if jump_num == 0:
				velocity.y = jump_height
				jump_num = 0

# SECOND JUMP LOGIC BELOW IF DOUBLE JUMP ENABLED FROM INSPECTOR
	if Input.is_action_just_pressed("jump")and not is_on_floor():
		if double_jump == true:
			if jump_num == 0:
				velocity.y += jump_height
				jump_num = 2
	if is_on_floor():
		jump_num = 0

# REDUCES PLAYER LIFE STATS FROM ENEMY ATTACK
func take_damage(damage):
	CURRENT_HEALTH -= damage
	
	if CURRENT_HEALTH <= 0:
		die()

# CALLED WHEN OUR HEALTH REACHES 0 
func die ():
	get_tree().reload_current_scene()

# ADDS AN AMOUNT OF HEALTH TO THE PLAYER
func add_health (amount):
	CURRENT_HEALTH += amount
	if CURRENT_HEALTH >= MAX_HEALTH:
		CURRENT_HEALTH = 100

# ADDS 1 TO THE SCORE WHEN PLAYER ENTERS COIN
func add_score (amount):
	score += 1

func speed_power_up():
	powerup = true
	walk_speed = powerup_speed
	Powerup.text = "Speed Powerup Activated"
	yield(get_tree().create_timer(speed_boost_time),"timeout")
	Powerup.text = "Speed Powerup Deactivated"
	walk_speed = 17
	yield(get_tree().create_timer(2),"timeout")
	powerup = false

func jump_power_up():
	powerup = true
	jump_height = powerup_jump
	Powerup.text = "Jump Powerup Activated"
	yield(get_tree().create_timer(jump_boost_time),"timeout")
	Powerup.text = "Jump Powerup Deactivated"
	jump_height = 17
	yield(get_tree().create_timer(2),"timeout")
	powerup = false
