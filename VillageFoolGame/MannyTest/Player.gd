extends KinematicBody2D


# Declare member variables here. Examples:
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

func _physics_process(delta):
	#get direction vector              V  x = 1 - 0             V  x = 0 - 1
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		#===Animations===
		animTree.set("parameters/Idle/blend_position", direction)
		animTree.set("parameters/Run/blend_position", direction)
		animState.travel("Run")
		#===Physics===
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCEL_SPEED * delta)
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION_SPEED * delta)
	
	velocity = move_and_slide(velocity)

