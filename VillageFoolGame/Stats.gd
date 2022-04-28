extends Node

export var Name = "BoJangles"
export var HP = 22 setget _HP
export var MaxHP = 33 setget _MaxHP
export var EP = 05
export var MaxEP = 07
export var Condition = "Bitchin'"
export var Attack = 666
export var Defence = 999
export var Power = 9001
export var Speed = 420

signal dead
signal tired

func _MaxHP(v):
	MaxHP = min(1, MaxHP)

func _HP(v):
	HP = clamp(v, 0, MaxHP)
	if HP <= 0:
		emit_signal("dead")
