extends Node2D

var active = false
var input = Vector2.ZERO
enum {NONE, JOSEPH, EMILY, ARTHUR, REYN}
var currSelected = NONE

onready var G = $Globals

signal pressed

func _ready():
	Input.action_release("up") #hard fix for active on startup (no RESET anim)
	visible = false
	$J.play("Idle")
	$E.play("Locked")
	$A.play("Locked")
	$R.play("Locked")

func _process(delta):
	#----------------------------------
	#Input handle (opening)
	if Input.is_action_just_pressed("radial"):
		currSelected = NONE
		$J.animation = "Idle"
		$E.animation = "Idle" if G.hasEmily else "Locked"
		$A.animation = "Idle" if G.hasArthur else "Locked"
		$R.animation = "Idle" if G.hasReyn else "Locked"
		
		emit_signal("pressed")
	if Input.is_action_just_released("radial"):
		currSelected = NONE
		emit_signal("pressed")
	#----------------------------------
	#Input handle (post open)
	print(input)
	if active:
		input = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
		input = input.normalized()
		
		if input.y < -0.8:
			currSelected = JOSEPH
		elif input.x > 0.8:
			currSelected = EMILY if G.hasEmily else currSelected
		elif input.x < -0.8:
			currSelected = ARTHUR if G.hasArthur else currSelected
		elif input.y > 0.8:
			currSelected = REYN if G.hasReyn else currSelected
		
	match currSelected:
		NONE:
			pass
		JOSEPH:
			$J.animation = "Hovered"
			$E.animation = "Idle" if G.hasEmily else "Locked"
			$A.animation = "Idle" if G.hasArthur else "Locked"
			$R.animation = "Idle" if G.hasReyn else "Locked"
		EMILY:
			$J.animation = "Idle"
			$E.animation = "Hovered" if G.hasEmily else "Locked"
			$A.animation = "Idle" if G.hasArthur else "Locked"
			$R.animation = "Idle" if G.hasReyn else "Locked"
		ARTHUR:
			$J.animation = "Idle"
			$E.animation = "Idle" if G.hasEmily else "Locked"
			$A.animation = "Hovered" if G.hasArthur else "Locked"
			$R.animation = "Idle" if G.hasReyn else "Locked"
		REYN:
			$J.animation = "Idle"
			$E.animation = "Idle" if G.hasEmily else "Locked"
			$A.animation = "Idle" if G.hasArthur else "Locked"
			$R.animation = "Hovered" if G.hasReyn else "Locked"
			
func activate():
	print("now active")
	visible = true
	get_tree().paused = true
	active = true
	$RadialAnimator.play("Activate")
	$ColorRect.visible = true
func deactivate():
	print("now inactive")
	get_tree().paused = false
	active = false
	$RadialAnimator.play_backwards("Activate")
	$ColorRect.visible = false

func _on_RadialMenu_pressed():
	if active:
		deactivate()
	else:
		activate()
