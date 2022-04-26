extends KinematicBody2D

var directionVec = Vector2.ZERO
var velocity = Vector2.ZERO

const MAXSPEED = 111
const ACCEL = 800

onready var sprite = $Sprite
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	directionVec = Vector2( (Input.get_action_strength("right") - Input.get_action_strength("left")), (Input.get_action_strength("down") - Input.get_action_strength("up") ) ).normalized()
	
	if directionVec != Vector2.ZERO:
		velocity = velocity.move_toward(directionVec * MAXSPEED, ACCEL * delta)
		sprite.flip_h = velocity.x > 0
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCEL * delta)
	
	if Input.is_action_pressed("interact"):
		animation.play("Talk")
	else: animation.play("Idle")
	
	velocity = move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
