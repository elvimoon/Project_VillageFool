extends Node

export(int) var maxHP = 3
export(int) var damage = 0

onready var HP = maxHP setget setHP

signal dead
signal hpChanged(v)
signal maxChanged(v)

func setMax(v):
	maxHP = v
	self.HP = min(HP, maxHP)
	emit_signal("maxChanged", maxHP)

func setHP(v):
	HP = v
	emit_signal("hpChanged", HP)
	if HP <= 0:
		emit_signal("dead")
