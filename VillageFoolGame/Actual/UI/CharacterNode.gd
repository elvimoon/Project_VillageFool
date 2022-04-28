extends Panel


func _ready():
	get_node("CharName").text = CharacterName
	get_node("Condition").text = Condition
	get_node("HPVal").text = ("%s/%s") % [HP, MaxHP]
	get_node("EPVal").text = ("%s/%s") % [EP, MaxEP]
	get_node("StatsGrid/ATT").text = str(Attack)
	get_node("StatsGrid/DEF").text = str(Defence)
	get_node("StatsGrid/POW").text = str(Power)
	get_node("StatsGrid/SPD").text = str(Speed)
