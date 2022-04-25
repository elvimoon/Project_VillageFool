extends Area2D

var player = null
var originalSize = Vector2.ZERO

func _ready():
	originalSize = get_node("CollisionShape2D").scale

func _physics_process(delta):
	pass

func sees_player():
	return player != null

func _on_DetectZone_body_entered(body):
	player = body
	get_node("CollisionShape2D").scale = get_node("CollisionShape2D").scale * 2

func _on_DetectZone_body_exited(body):
	get_node("CollisionShape2D").scale = originalSize
	player = null
