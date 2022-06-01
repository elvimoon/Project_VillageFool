extends Node


export(int, 1, 9999999) var MaxHP = 10
export(int, 1, 9999999) var MaxEP = 5
export(int, 10) var Attack = 1
export(int, 10) var Defence = 1

var isDead = false
var isEmpty = false
var HP = MaxHP setget _HP
var EP = MaxEP setget _EP


signal dead
signal noEnergy
###===SYSTEM FUNCS===###
func _ready():
	pass
###===USER FUNCS===###

###===SETGETS===###
func _HP(v):
	HP = v
	if HP <= 0:
		emit_signal("dead")
	HP = clamp(HP, 0, MaxHP)
func _EP(v):
	EP = v
	if HP <= 0:
		emit_signal("noEnergy")
	EP = clamp(EP, 0, MaxEP)
