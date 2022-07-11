extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if rect_global_position != get_parent().find_node("Camera2D").get_camera_position():
		rect_global_position = get_parent().find_node("Camera2D").get_camera_position()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

