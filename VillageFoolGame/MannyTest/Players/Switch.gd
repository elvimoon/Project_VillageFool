extends Node
onready var currChar = $Joseph

func _ready():
	currChar.activate()
	
func switch_char(to):
	currChar.deactivate()
	currChar = to
	currChar.activate()
