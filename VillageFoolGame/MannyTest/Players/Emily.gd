extends "res://MannyTest/Players/Character.gd"

var hovered = false
var channelling = false


func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		pass
	if !hovered:
		hover()
		if motion.y >= 0:
			$Emily/HoverTimer.start()
	motion = move_and_slide(motion, Vector2.UP)
#=====================================================================
func hover():
	if Input.get_action_strength("jump") != 0 and motion.y >= 0:
			motion.y = 0
