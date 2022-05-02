extends Control

export var selected = false

onready var arrow = $OptionArrow

func _ready():
	arrow.frame = 0
	
func _process(delta):
	if selected:
		arrow.play("d")
	else:
		arrow.stop()
		arrow.frame = 1
