extends Node

export(String) var Name = "BoJangles"
export(int, 1, 50) var level = 1 setget _levelUp
export(int, 5, 20) var baseHP = 10
export(int, 5, 20) var baseEP = 10
export(int, 10, 35) var baseATT = 15
export(int, 10, 35) var baseDEF = 15
export(int, 10, 35) var basePOW = 25
export(int, 10, 35) var baseSPD = 20

var HP = 1 setget _HP
var MaxHP = baseHP setget _MaxHP
var EP = 05 setget _EP
var MaxEP = 07 setget _MaxEP
var Condition = "Bitchin'" setget _status
var Attack setget _ATT
var Defence setget _DEF
var Power setget _POW
var Speed setget _SPD
var damage = 1
var currentSpellDmg = 1
var difficulty = Settings.statMod
var EXP = 1 setget _addExp

signal dead
signal tired
signal statChange(stat, value)
signal statusChange(condition)
signal maxLevel
signal levelUp

###===USER FUNCS===###
func getTurnTicks(totalSpeed):
	return Speed / totalSpeed
#outgoing hits
func getRegHurt(entityDefence):
	damage = (Attack - entityDefence * difficulty) / 10
func getPowHurt(entityDefence, spell):
	currentSpellDmg = spell.damage
	damage = (currentSpellDmg * Power - entityDefence * difficulty) / 10
#incoming hits 
func getRegHit(entityAttack):
	HP -= (entityAttack * difficulty - Defence) / 10
func getPowHit(entityPower, spell):
	HP -= (entityPower * spell.damage * difficulty - Defence) / 10
###===SETGETS===###
func _MaxHP(lvl):##------------------------------------- Max HP
	MaxHP = clamp(baseHP * lvl * 1.0312, 1, 999)
	emit_signal("statChange", "MaxHP", MaxHP)
func _HP(v):##------------------------------------------ HP
	HP = clamp(v, 0, MaxHP)
	if HP <= 0:
		emit_signal("dead")
func _MaxEP(lvl):##------------------------------------- Max EP
	MaxEP = baseEP * lvl * 0.9
	MaxEP = clamp(baseEP * lvl * 1.0312, 0, 999)
	emit_signal("statChange", "MaxEP", MaxEP)
func _EP(v):##------------------------------------------ EP
	EP = clamp(v, 0, MaxEP)
	if EP <= 0:
		emit_signal("tired")
func _status(v):##-------------------------------------- Status
	Condition = v
	emit_signal("statChange", "Status", Condition)
func _ATT(lvl):##--------------------------------------- Attack
	Attack = clamp(baseATT * lvl * 6189, 0, 9999999)
	emit_signal("statChange", "ATT", Attack)
func _DEF(lvl):##--------------------------------------- Defence
	Defence = clamp(baseDEF * lvl * 6189, 0, 9999999)
	emit_signal("statChange", "DEF", Defence)
func _POW(lvl):##--------------------------------------- Power
	Power = clamp(basePOW * lvl * 6189, 0, 9999999)
	emit_signal("statChange", "POW", Power)
func _SPD(lvl):##--------------------------------------- Speed
	Speed = clamp(baseSPD * lvl * 6189, 0, 9999999)
	emit_signal("statChange", "SPD", Speed)
func _levelUp(v):##------------------------------------- Level
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
	if EXP >= expReqForLevelUp:
		level += 1
		emit_signal("levelUp")
