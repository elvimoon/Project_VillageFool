extends RemoteTransform2D


onready var camera = get_tree().current_scene.find_node("Camera 2D")

func _ready():
	camera = get_tree().current_scene.get_node("Camera")

func _process(_delta):
	camera.global_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
