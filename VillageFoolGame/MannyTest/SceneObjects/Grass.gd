extends Node2D

onready var GrassEffect = load("res://MannyTest/Effects/GrassEffect.tscn")
###===SYSTEM FUNCTIONS===###
func _process(delta):
	pass

###===USER FUNCTIONS===###


func _on_HurtBox_area_entered(area):
	var world = get_tree().current_scene
	var grassEffect = GrassEffect.instance()

	world.add_child(grassEffect)
	grassEffect.global_position = global_position
	queue_free()
