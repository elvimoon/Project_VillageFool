extends Camera2D

## Relative to the current_scene
export var PlayerNodePath = "" 

onready var player = get_tree().current_scene.get_node(PlayerNodePath)

func _process(delta):
	
	global_position = player.global_position
