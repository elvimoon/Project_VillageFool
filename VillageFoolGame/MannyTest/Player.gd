extends KinematicBody2D

export(float) var Gravity = 9.8
export(int, 1, 99999) var MaxSpeed
export(int, 1, 99999) var Acceleration
export(int, 1, 99999) var Friction
export(float) var JumpPower

var motion = Vector2.ZERO
var direction = 1
#onready var joseph = $Joseph
#onready var emily = $Emily
#onready var arthur = $Arthur
#onready var reyn = $Reynauld
#onready var currentChar = joseph

func _physics_process(delta):
	motion.y += Gravity
	direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if is_on_floor():
		if Input.is_action_just_pressed("up"):
			print("")
			motion.y = -JumpPower
	if direction != 0:
		motion = motion.move_toward(Vector2(direction * MaxSpeed, motion.y), Acceleration)
	else:
		motion = motion.move_toward(Vector2(0, motion.y), Friction)

	
	motion = move_and_slide(motion, Vector2.UP)
