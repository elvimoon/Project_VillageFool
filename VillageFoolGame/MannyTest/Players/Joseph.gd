extends "res://MannyTest/Players/Character.gd"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		pass
	motion = move_and_slide(motion, Vector2.UP)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
