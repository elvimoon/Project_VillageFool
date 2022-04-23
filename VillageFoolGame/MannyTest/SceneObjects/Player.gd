extends KinematicBody2D
# Declare member variables here. Examples:

enum {
	MOVE, ATTACK, ROLL
}

var state = MOVE
var velocity = Vector2.ZERO
var direction = Vector2.ZERO

const FRICTION_SPEED = 800
const ACCEL_SPEED = 2000
const MAX_SPEED =88

onready var animationPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var camera = $Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	animTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move(delta)
		ROLL:
			dodge(delta)
		ATTACK:
			attack(delta)
	

func attack(delta):
	animState.travel("Attack")
	velocity = Vector2.ZERO
	

func dodge(delta):
	animState.travel("Dodge")

func move(delta):
	#get direction vector              V  x = 1 - 0             V  x = 0 - 1
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	#===Movement===
	if direction != Vector2.ZERO:
		#===Animations===
		animTree.set("parameters/Idle/blend_position", direction)
		animTree.set("parameters/Run/blend_position", direction)
		animTree.set("parameters/Attack/blend_position", direction)
		animTree.set("parameters/Dodge/blend_position", direction)
		animState.travel("Run")
		#===Physics===
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCEL_SPEED * delta)
	#===No Movement===
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION_SPEED * delta)
	
	#===State Machine===
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	elif Input.is_action_just_pressed("dodge"):
		state = ROLL
	#Do
	velocity = move_and_slide(velocity)

func anim_ended():
	state = MOVE
