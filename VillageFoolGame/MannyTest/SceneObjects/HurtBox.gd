extends Area2D

export(bool) var HitEffect = true
export(float) var iFrameLength = 1

const hitEffect = preload("res://MannyTest/Effects/HitEffect.tscn")

var invuln = false 

onready var timer = $Timer

signal isInvincible
signal isVincible

func hit_effect():
	var effect = hitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func isInvuln():
	emit_signal("isInvincible")
	self.invuln = true
	timer.start(iFrameLength)

#CURRENTLY DOES NOT WORK
func _on_HurtBox_isInvincible():
	print(monitorable)
	set_deferred("monitorable", false)
#CURRENTLY DOES NOT WORK
func _on_HurtBox_isVincible():
	print(monitorable)
	monitorable = true

func _on_Timer_timeout():
	self.invuln = false #self must be included to call THIS invuln, to prevent recursion
	emit_signal("isVincible")


func _on_HurtBox_area_entered(area):
	if HitEffect:
		hit_effect()
	isInvuln()

