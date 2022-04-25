extends Control

var hp = 4 setget setHP
var maxHP = 4 setget setMaxHP

onready var full = $HeartFull
onready var empty = $HeartEmpty

func setHP(v):
	hp = clamp(v, 0, maxHP)
	if full != null:
		full.rect_size.x = hp * 15

func setMaxHP(v):
	maxHP = max(v, 1)
	empty.rect_size.x = maxHP * 15

func _ready():
	self.maxHP = PlayerStats.maxHP
	self.hp = PlayerStats.HP
	PlayerStats.connect("hpChanged", self, "setHP")
	PlayerStats.connect("maxChanged", self, "maxHP")
