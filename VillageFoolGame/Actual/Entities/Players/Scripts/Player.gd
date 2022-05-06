extends KinematicBody2D

##exports
#constants
const MAXSPEED = 90
const ACCEL = 800
##variables
var directionVec = Vector2.ZERO
var velocity = Vector2.ZERO
##onreadies
onready var sprite = $Sprite
onready var animTree = $AnimationTree
onready var animation = animTree.get("parameters/playback")
###===USER FUNCTIONS===###

###===SYSTEM FUNCTIONS===###
func _ready():
	animTree.active = true
	animation.travel("Idle")

func _physics_process(delta):
	directionVec = Vector2( (Input.get_action_strength("right") - Input.get_action_strength("left")), (Input.get_action_strength("down") - Input.get_action_strength("up") ) ).normalized()
	
	if directionVec != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", directionVec)
		animTree.set("parameters/Run/blend_position", directionVec)
		animation.travel("Run")
		velocity = velocity.move_toward(directionVec * MAXSPEED, ACCEL * delta)

	else:
		animation.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, ACCEL * delta)
	
	velocity = move_and_slide(velocity)

