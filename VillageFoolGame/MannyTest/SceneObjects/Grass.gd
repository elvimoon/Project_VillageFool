extends Node2D

const GrassEffect = preload("res://MannyTest/Effects/GrassEffect.tscn")
###===SYSTEM FUNCTIONS===###
func _process(delta):
	pass

###===USER FUNCTIONS===###


func _on_HurtBox_area_entered(area):
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position
	queue_free()
