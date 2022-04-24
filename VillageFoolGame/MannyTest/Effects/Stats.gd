extends Node

export(int) var maxHP = 3
export(int) var damage = 0

onready var HP = maxHP setget setHP

signal dead
signal invincible

export(bool) var invuln = false setget setIframe

func setHP(val):
	HP = val
	print(HP)
	if HP <= 0:
		emit_signal("dead")

func setIframe(state):
	invuln = state
	if invuln == true:
		emit_signal("invincible")
