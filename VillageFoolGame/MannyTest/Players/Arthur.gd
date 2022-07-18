extends "res://MannyTest/Players/Character.gd"


const DashDist = 100
var nearWall
var wallJump
var canSlice
var canDash = true
var dashing = false
var prevPos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		pass
	dash()
	if is_on_wall():
		if motion.y < 0 and !Input.is_action_just_pressed("jump"):
			motion.y = 0
		if input == get_wall_side():
			motion.y += GRAVITY * 0.1
	motion = move_and_slide(motion, Vector2.UP)
func dash():
	if Input.is_action_pressed("special") and canDash:
		$DashTimer.start()
		canDash = false
		prevPos = global_position.x
		if input !=0:
			motion.x = 2000 * input
		else: motion.x = 2000 if front == 1 else -2000
		dashing = true
	if dashing == true:
		motion.y = 0
		if global_position.x >= prevPos + DashDist or global_position.x <= prevPos - DashDist or motion.x == 0 or is_on_wall():
			motion.x = 0
			dashing = false
func get_wall_side():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return -1
		elif collision.normal.x < 0:
			return 1
	return 0
