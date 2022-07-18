extends KinematicBody2D

export var active = false

const GRAVITY = 18
export(float) var MAXSPEED
export(float) var ACCEL
export(float) var DECEL
export(float) var JUMPH

var motion = Vector2.ZERO
#State Flags (Numeric)
var input = 0
var front = 1
var jumps = 1
var dead = false
#Global States
enum        {HAS_SKATES, GROUND,   MOVEABLE, AIR,     TIRED,  DYING}
var state = [false,      true,     true,     false,   false,  false]
###Object Referencing
#Stats
onready var hp = $Stats.HP
onready var ep = $Stats.EP
onready var def = $Stats.Defence
onready var att = $Stats.Attack
#Collisions/Areas
onready var hurtbox = $HurtBox
onready var hitbox = $HitBox

func _process(delta):
	input = Input.get_action_strength("right") - Input.get_action_strength("left")
	if active:
		$Camera.update_position = true
	else: $Camera.update_position = false
	#updateStates()

func _physics_process(delta):

	motion.y += GRAVITY

	if state[MOVEABLE]:
		move()
		jump()
	updateStates()
#=====================================================================
func move():
	#check for inputDir flip
	if input != 0:
		motion = motion.move_toward(Vector2(input * MAXSPEED, motion.y), ACCEL)
	else:
		motion = motion.move_toward(Vector2(0, motion.y), DECEL)
func jump():
	if Input.is_action_just_pressed("jump"):
		if jumps > 0:
			jumps -= 1
			motion.y = -JUMPH
		else:
			print("Can't Jump right now")
			
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = 10
func updateStates():
	#direction check and toggle
	if input != front and input !=0:
		front = input
		self.scale.x = -1
	#ground check
	if is_on_floor():
		state[GROUND] = true
		state[AIR] = false
		jumps = 2 if state[HAS_SKATES] else 1
	else: 
		state[GROUND] = false
		state[AIR] = true
	state[TIRED] = true if ep <= 0 else false
	state[DYING] = true if hp <= 0 else false

	dead = true if hp <= 0 else false
func activate(pos):
	active = true
	global_position = pos
	$Camera.update_position = true
func deactivate():
	active = false
	$Camera.update_position = false
	
