extends KinematicBody2D

###Physics
#>Global Consts
const GRAVITY = 18
#enum            {JOSEPH = 0, EMILY, ARTHUR, REYN}
const MAXSPEED = [155,        145,   175,    125] #TIED TO currChar ENUM
const ACCEL =    [100,        90,    120,    75]#TIED TO currChar ENUM
const DECEL =    [10,         9.7,   15,     7]#TIED TO currChar ENUM
const JUMPH =    [500,        500,   555,    475]#TIED TO currChar ENUM
const DashDistance = 100

#>Variables
var motion = Vector2.ZERO

###Character Referencing
onready var JStat = $Joseph/Stats
onready var EStat = $Emily/Stats
onready var AStat = $Arthur/Stats
onready var RStat = $Reynauld/Stats

export(PackedScene) onready var projectile
#onready var wallCheck = $Arthur/WallCheck

###State Flags
#numerical state flags
var input = 0
var front = 1
var jumps = 1
var prevPos = 0
#toggled state flags
enum           {JOSEPH = 0, EMILY, ARTHUR, REYN}
var PDead    = [false,      false, false,  false]#TIED TO currChar ENUM
var currChar = JOSEPH
enum        {HAS_SKATES, CAN_DASH, DASHING, HOVERED, GROUND, MOVEABLE, AIR,   TIRED, DYING}
var state = [true,       true,     false,   true,    false,  true,     false, false, false]

###---System Functions---###
func _ready():
	pass

func _process(delta):
	input = Input.get_action_strength("right") - Input.get_action_strength("left")
	updateStates()
	
func _physics_process(delta):
	if currChar == JOSEPH and Input.is_action_just_pressed("attack"):
		pass
	
	if currChar != ARTHUR: motion.y += GRAVITY

	if currChar == ARTHUR:
		dash()
		if is_on_wall():
			if motion.y < 0 and !Input.is_action_just_pressed("jump"):
				motion.y = 0
			if input == get_wall_side():
				motion.y += GRAVITY * 0.1
	if state[MOVEABLE]:
		move()
	jump()
	if currChar == EMILY:
		if !state[HOVERED]:
			hover()
		
	motion = move_and_slide(motion, Vector2.UP)

###---User Functions---###
##>>Movement
func move():
	#check for inputDir flip
	if input != 0:
		motion = motion.move_toward(Vector2(input * MAXSPEED[currChar], motion.y), ACCEL[currChar])
	else:
		motion = motion.move_toward(Vector2(0, motion.y), DECEL[currChar])
func jump():
	if Input.is_action_just_pressed("jump"):
		if motion.y >= 0 and !state[HOVERED]:
			$Emily/HoverTimer.start()
		if jumps > 0:
			jumps -= 1
			motion.y = -JUMPH[currChar]
		else:
			print("Can't Jump right now")
	if Input.is_action_just_released("jump") and !is_on_wall():
		if motion.y < -20:
			motion.y = 0
func wallJump():
	pass
func dash():
	if Input.is_action_pressed("special") and state[CAN_DASH]:
		$DashTimer.start()
		state[CAN_DASH] = false
		prevPos = global_position.x
		if input !=0:
			motion.x = 2000 * input
		else: motion.x = 2000 if front == 1 else -2000
		state[DASHING] = true
	if state[DASHING] == true:
		motion.y = 0
		if global_position.x >= prevPos + DashDistance or global_position.x <= prevPos - DashDistance or motion.x == 0 or is_on_wall():
			motion.x = 0
			state[DASHING] = false
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
func updateStates():
	#direction check and toggle
	if input != front and input !=0:
		front = input
		self.scale.x = -1
	#ground check
	if is_on_floor():
		state[GROUND] = true
		$Camera.position = $Camera.position.move_toward(Vector2(0,-32), 2)
		state[AIR] = false
		state[HOVERED] = false
		jumps = 2 if state[HAS_SKATES] else 1
	else: 
		state[GROUND] = false
		$Camera.position = $Camera.position.move_toward(Vector2.ZERO, 2)
		state[AIR] = true
	checkCharStates()
func checkCharStates():
	match currChar: #EP/HP check (for current player only)
		JOSEPH:
			state[TIRED] = true if JStat.EP <= 0 else false
			state[DYING] = true if JStat.HP <= 0 else false
		EMILY:
			state[TIRED] = true if EStat.EP <= 0 else false
			state[DYING] = true if EStat.HP <= 0 else false
		ARTHUR:
			state[TIRED] = true if AStat.EP <= 0 else false
			state[DYING] = true if AStat.HP <= 0 else false
		REYN:
			state[TIRED] = true if RStat.EP <= 0 else false
			state[DYING] = true if RStat.HP <= 0 else false
	#is dead checks
	PDead[JOSEPH] = true if JStat.HP <= 0 else false
	PDead[EMILY] = true if JStat.HP <= 0 else false
	PDead[ARTHUR] = true if JStat.HP <= 0 else false
	PDead[REYN] = true if JStat.HP <= 0 else false

#>Signals
func _on_HoverTimer_timeout():
	state[HOVERED] = true
func _on_DashTimer_timeout():
	state[CAN_DASH] = true
