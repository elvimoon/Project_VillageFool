extends Node

enum Difficulties {EASY = 0, MEDIUM, HARD}

export(Difficulties) var Difficulty = Difficulties.EASY

var statMod = 0.5

func _ready():
	match Difficulty:
		Difficulties.EASY:
			statMod = 0.25
		Difficulties.MEDIUM:
			statMod = 0.5
		Difficulties.HARD:
			statMod = 1
