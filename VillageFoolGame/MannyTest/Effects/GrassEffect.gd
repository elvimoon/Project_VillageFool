extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.frame = 0
	sprite.play("Animate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()
