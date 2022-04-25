extends KinematicBody2D
# Declare member variables here. Examples:

enum {
	MOVE, ATTACK, ROLL
}

var state = MOVE
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var roll_vec = Vector2.DOWN
var dodgeCooldown = 10
var stats = PlayerStats

const FRICTION_SPEED = 800
const ACCEL_SPEED = 2000
const MAX_SPEED =88

onready var animationPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var swordBox = $SwordBoxPivot/SwordHitBox
onready var hurtBox = $HurtBox
onready var camera = $Camera2D

###===SYSTEM PROCESSES===###
# Called when the node enters the scene tree for the first time
func _ready():
	animTree.active = true
	swordBox.knockback_vec = roll_vec
	stats.connect("dead", self, "respawn")
# Called as fast as possible, delta is varied here (before physical processing)
func _process(delta):
	pass
# Called after pre-process, delta is stable here
func _physics_process(delta):
	match state:
		MOVE:
			move(delta)
		ROLL:
			dodge(delta)
		ATTACK:
			attack(delta)

###===USER FUNCTIONS===###
func attack(delta):
	animState.travel("Attack")
	velocity = Vector2.ZERO
	

func dodge(delta):
	velocity = roll_vec * MAX_SPEED * 2 #<- This is the initial "Jump"
	swordBox.knockback_vec = roll_vec
	animState.travel("Dodge")
	velocity = move_and_slide(velocity)

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
		swordBox.knockback_vec = direction
		roll_vec = direction
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCEL_SPEED * delta)
	#===No Movement===
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION_SPEED * delta)
	
	#===State Machine===
	if Input.is_action_pressed("attack"):
		state = ATTACK
	elif Input.is_action_pressed("dodge"):
		if dodgeCooldown <= 0:
			dodgeCooldown = 10
			state = ROLL
		else:
			state = MOVE
	#Do
	if dodgeCooldown >= 0:
		dodgeCooldown -= 0.25
	velocity = move_and_slide(velocity)

func anim_ended():
	velocity /= 2
	state = MOVE

func _on_HurtBox_area_entered(area):
	stats.HP -= 1

func respawn():
	PlayerStats.HP = 5
	global_position = Respawn.global_position
