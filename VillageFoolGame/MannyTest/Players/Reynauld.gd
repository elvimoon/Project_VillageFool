extends "res://MannyTest/Players/Character.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var blocking = false
var aura = false
var pounding = false

onready var blocker = $BlockBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta): 
	checkState()
func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		pass
	if blocking:
		block()
		
	motion = move_and_slide(motion, Vector2.UP)
#=====================================================================
func checkState():
	if Input.is_action_pressed("block"):
		blocking = true
	
func block():
	MAXSPEED /= 2
	hurtbox.disabled = true
	blocker.disabled = false
	#if blocker is collided with, play animation/deflect/w.e
	
