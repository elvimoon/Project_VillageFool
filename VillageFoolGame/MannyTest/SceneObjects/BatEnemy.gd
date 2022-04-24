extends KinematicBody2D
######------VARIABLES------######
#variables
const HITFORCE = 333
var knockback = Vector2.ZERO
#objects to load
var DeathEffect = preload("res://MannyTest/Effects/DeathEffect.tscn")
onready var stats = $Stats
######------FUNCTIONS-----######
###===SYSTEM===###
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 3 * HITFORCE * delta)
	knockback = move_and_slide(knockback)
###===SIGNALS===###
func _on_HurtBox_area_entered(area):
	stats.HP -= area.damage
	knockback = area.knockback_vec * HITFORCE
func _on_Stats_dead():
	die()
	queue_free()
###===USER===###
func die():
	var deathEffect = DeathEffect.instance()
	deathEffect.global_position = global_position
	print("deathEffect instance created")
	get_parent().add_child(deathEffect)
