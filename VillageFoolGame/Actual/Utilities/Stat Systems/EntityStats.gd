extends Node

export(String) var Name = "BoJangles"
export(String, "Bitchin'", "Groovy", "Gnarly", "Tubular", "Paralyzed", "Sleep", "Bleeding", "On fire!", "Slow", "Weak", "Drained", "Hyper", "Buff", "Energized", "Sturdy", "Flimsy") var Condition = "Bitchin'" setget _status
export(float, 1, 50, 1) var level = 1 setget _levelUp
export(float, 5, 20, 1) var baseHP = 10
export(float, 0, 20, 1) var baseEP = 10
export(float, 5, 8, 0.5) var baseATT = 8
export(float, 5, 8, 0.5) var baseDEF = 7
export(float, 5, 8, 0.5) var basePOW = 6
export(float, 5, 8, 0.5) var baseSPD = 6

var HP = MaxHP setget _HP
var MaxHP setget _MaxHP
var MaxEP setget _MaxEP
var EP = MaxEP setget _EP
var Attack setget _ATT
var Defence setget _DEF
var Power setget _POW
var Speed setget _SPD
var damage = 1
var currentSpellDmg = 1
#var difficulty = Settings.statMod
var EXP = 1 setget _addExp

signal dead
signal tired
signal statChange(stat, value)
signal maxLevel
signal levelUp

###===SYSTEM FUNCS===###
func _ready():
	Attack = getStat(baseATT, level)
	Defence = getStat(baseDEF, level)
	Power = getStat(basePOW, level)
	Speed = getStat(baseSPD, level)
	MaxHP = round(clamp(baseHP * level * 1.0312, 1, 999))
	MaxEP = round(clamp(baseEP * level * 1.0312, 1, 999))
	HP = MaxHP
	EP = MaxEP
###===USER FUNCS===###
func getStat(base, lvl):
	var stat = clamp(base * lvl / 3.82 + 5, 0, 99)
	return round(stat)
###===SETGETS===###
func _MaxHP(v):##------------------------------------- Max HP
	HP = MaxHP
	emit_signal("statChange", "MaxHP", MaxHP)
func _HP(v):##------------------------------------------ HP
	HP = round(clamp(v, 0, MaxHP))
	if HP <= 0:
		emit_signal("dead")
func _MaxEP(v):##------------------------------------- Max EP
	EP = MaxEP
	emit_signal("statChange", "MaxEP", MaxEP)
func _EP(v):##------------------------------------------ EP
	EP = round(clamp(v, 0, MaxEP))
	if EP <= 0:
		emit_signal("tired")
func _status(v):##-------------------------------------- Status
	Condition = v
	emit_signal("statChange", "Status", Condition)
func _ATT(v):##--------------------------------------- Attack
	print("Assigning Attack")
	emit_signal("statChange", "ATT", Attack)
func _DEF(v):##--------------------------------------- Defence
	print("Assigning Defence")
	emit_signal("statChange", "DEF", Defence)
func _POW(v):##--------------------------------------- Power
	print("Assigning Power")
	emit_signal("statChange", "POW", Power)
func _SPD(v):##--------------------------------------- Speed
	print("AssigningSpeed")
	emit_signal("statChange", "SPD", Speed)
func _levelUp(v):##------------------------------------- Level
	print("Assigning Level")
	if v >= 50:
		emit_signal("maxLevel")
		level = 50
	else:
		level = v
		MaxHP = level
		HP = MaxHP
		MaxEP = level
		EP = MaxEP
		Attack = level
		Defence = level
		Power = level
		Speed = level
		EXP = 0
func _addExp(xp):##------------------------------------- EXP
	var expReqForLevelUp = 50 * pow(level-1, (0.9 + 30 / 250)) * level * (level-1) / (6 + (level*level) / 50 / 70) + (level-1) * 100
	EXP = xp
	print("Required EXP for next level is: %s" % EXP)
	if EXP >= expReqForLevelUp:
		level += 1
		emit_signal("levelUp")
