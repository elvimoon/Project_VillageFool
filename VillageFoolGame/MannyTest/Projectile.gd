extends Area2D

var spawnPos
var direction = 1
const speed = 5

func _ready():
	global_position = spawnPos

func _physics_process(delta):
	global_position.x += global_position.x * direction * speed


func _on_Projectile_body_entered(body):
	self.queue_free()
