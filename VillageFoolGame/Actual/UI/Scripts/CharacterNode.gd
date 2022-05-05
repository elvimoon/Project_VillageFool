extends Panel

export(String, "Char1","Char2","Char3","Char4") var Char = "Char1"
export(bool) var checkStats = false

var selected = false
var currentTurn = false

onready var stat = Character1Stats

func _ready():
	match Char:
		"Char1":
			stat = Character1Stats
		"Char2":
			stat = Character2Stats
		"Char3":
			stat = Character3Stats
		"Char4":
			stat = Character4Stats
	
	fillText(stat)
func _process(delta):
	if checkStats: get_node("CharacterSprite").visible = false
	if  selected:
		movePanelUp()
	else: 
		movePanelDown()
	if currentTurn == true: movePanelUp()
	else: movePanelDown()
func movePanelUp():
	self.rect_position.y = move_toward(rect_position.y, 33, 1)
func movePanelDown():
	self.rect_position.y = move_toward(rect_position.y, 94, 1)
func fillText(v):
	get_node("CharName").text = v.Name
	if v.Condition == "Paralyzed": self.get_node("Condition").add_color_override("font_color", Color(237, 255, 1))
	elif v.Condition == "Sleep": get_node("Condition").add_color_override("font_color", Color(1, 255, 216))
	elif v.Condition == "Bleeding":get_node("Condition").add_color_override("font_color", Color(167, 0, 45))
	elif v.Condition == "On fire!": get_node("Condition").add_color_override("font_color", Color(254, 103, 9))
	elif v.Condition == "Slow": get_node("Condition").add_color_override("font_color", Color(255, 10, 10))
	elif v.Condition == "Weak": get_node("Condition").add_color_override("font_color", Color(255, 10, 10))
	elif v.Condition == "Drained": get_node("Condition").add_color_override("font_color", Color(255, 10, 10))
	elif v.Condition == "Hyper": get_node("Condition").add_color_override("font_color", Color(0, 255, 0))
	elif v.Condition == "Buff": get_node("Condition").add_color_override("font_color", Color(0, 255, 0))
	elif v.Condition == "Energized": get_node("Condition").add_color_override("font_color", Color(0, 255, 0))
	elif v.Condition == "Sturdy": get_node("Condition").add_color_override("font_color", Color(0, 255, 0))
	elif v.Condition == "Flimsy": get_node("Condition").add_color_override("font_color", Color(255, 10, 10))
	elif v.Condition == "Bitchin'": self.get_node("Condition").add_color_override("font_color", Color(254, 103, 9))
	elif v.Condition == "Groovy": get_node("Condition").add_color_override("font_color", Color(0, 255, 0))
	elif v.Condition == "Gnarly": get_node("Condition").add_color_override("font_color", Color(167, 0, 45))
	elif v.Condition == "Tubular":get_node("Condition").add_color_override("font_color", Color(1, 255, 216))
	get_node("Condition").text = v.Condition
	
	get_node("HPVal").text = ("%s/%s") % [v.HP, v.MaxHP]
	get_node("EPVal").text = ("%s/%s") % [v.EP, v.MaxEP]
	get_node("StatsGrid/ATT").text = str(v.Attack)
	get_node("StatsGrid/DEF").text = str(v.Defence)
	get_node("StatsGrid/POW").text = str(v.Power)
	get_node("StatsGrid/SPD").text = str(v.Speed)
	
