extends GridContainer

var direction = Vector2.ZERO
onready var currentlySelected = get_node("Fight")
onready var node1 = $Fight
onready var node2 = $Powers
onready var node3 = $Items
onready var node4 = $Status
onready var node5 = $Examine
onready var node6 = $Run

#func _ready():
#	if node1 == null:
#		print("No node here")
#	if node2 == null:
#		print("No node here")
#	if node3 == null:
#		print("No node here")
#	if node4 == null:
#		print("No node here")
#	if node5 == null:
#		print("No node here")
#	if node6 == null:
#		print("No node here")
	

func _process(delta):
	grab_focus()
	if Input.is_action_just_pressed("down"):
		currentlySelected.selected = false
		currentlySelected.focus_neighbour_down.grab_focus()
	if Input.is_action_just_pressed("up"):
		currentlySelected.selected = false
		currentlySelected = currentlySelected.focus_neighbour_up.get_as_property_path()
	if Input.is_action_just_pressed("left"):
		currentlySelected.selected = false
		currentlySelected = currentlySelected.focus_neighbour_left.get_as_property_path()
	if Input.is_action_just_pressed("right"):
		currentlySelected.selected = false
		currentlySelected = currentlySelected.focus_neighbour_right.get_as_property_path()
	currentlySelected.selected = true
