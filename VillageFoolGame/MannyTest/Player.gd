extends KinematicBody2D

###Physics
#>Global Consts
const GRAVITY = 18
const MAXSPEED = [155, 145, 175, 125]
const ACCEL = [100, 90, 120, 75]
const DECEL = [10, 9.7, 15, 7]
const JUMPH = [500, 500, 555,475]
const DashDistance = 100

#>Variables
enum {JOSEPH = 0, EMILY, ARTHUR, REYN}
var currChar = ARTHUR
var motion = Vector2.ZERO
var prevPos = 0

###Character Referencing
onready var JStat = $Joseph/Stats
onready var EStat = $Emily/Stats
onready var AStat = $Arthur/Stats
onready var RStat = $Reynauld/Stats
onready var wallCheck = $WallCheck

###State Flags
var inputDir = 0
var front = 1
var hasSkates = true
var jumpsLeft = 1
var canDash = true
var dashing = false
var hovered = false

###---System Functions---###
func _ready():
	pass

func _process(delta):
	if is_on_floor(): 
		hovered = false
		jumpsLeft = 2 if hasSkates else 1
		
	if inputDir != front and inputDir !=0:
		front = inputDir
		self.scale.x = -1

func _physics_process(delta):
	
	inputDir = Input.get_action_strength("right") - Input.get_action_strength("left")
	move()
	jump()
	if currChar == ARTHUR:
		dash()
	if currChar == EMILY:
		if !hovered:
			hover()
	if is_on_wall() and inputDir == get_wall_side() and currChar == ARTHUR:
		motion.y += GRAVITY * 0.1
	else: motion.y += GRAVITY
	motion = move_and_slide(motion, Vector2.UP)

###---User Functions---###
##>>Movement
func move():
	#check for inputDir flip
	if inputDir != 0:
		motion = motion.move_toward(Vector2(inputDir * MAXSPEED[currChar], motion.y), ACCEL[currChar])
	else:
		motion = motion.move_toward(Vector2(0, motion.y), DECEL[currChar])
func jump():
	if Input.is_action_just_pressed("jump"):
		if motion.y >= 0 and !hovered:
			$Emily/HoverTimer.start()
		if jumpsLeft > 0:
			jumpsLeft -= 1
			motion.y = -JUMPH[currChar]
		else:
			print("Can't Jump right now")

	if Input.is_action_just_released("jump"):
		if motion.y < -20:
			motion.y = 0
func dash():
	if Input.is_action_pressed("special") and canDash:
		$DashTimer.start()
		canDash = false
		prevPos = global_position.x
		if inputDir !=0:
			motion.x = 2000 * inputDir
		else: motion.x = 2000 if front == 1 else -2000
		dashing = true
	if dashing == true:
		motion.y = 0
		if global_position.x >= prevPos + DashDistance or global_position.x <= prevPos - DashDistance or motion.x == 0 or is_on_wall():
			motion.x = 0
			dashing = false

func hover():
	if Input.get_action_strength("jump") != 0 and motion.y >= 0:
			motion.y = 0
##>>Utilities
func get_wall_side():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return -1
		elif collision.normal.x < 0:
			return 1
	return 0
#>Signals
func _on_HoverTimer_timeout():
	hovered = true
func _on_DashTimer_timeout():
	canDash = true
