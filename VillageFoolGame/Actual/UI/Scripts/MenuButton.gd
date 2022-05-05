tool
extends Control

export(String) var Text = " "

var focused = false

onready var arrow = $OptionArrow
onready var label = $MenuButton

func _ready():
	arrow.frame = 1
	arrow.stop()
	set_focus_mode(true)
	label.text = Text
	
func _process(delta):
	if Engine.editor_hint:
		if label != null:
			label.text = Text
func _on_Button_focus_entered():
	focused = true
	arrow.frame = 0
	arrow.play("d")
	print("Button Focused")

func _on_Button_focus_exited():
	focused = false
	arrow.stop()
	arrow.frame = 1

func _on_Button_pressed():
	print("Button was pressed")
