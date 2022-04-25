extends KinematicBody2D
######------VARIABLES------######
#variables
enum { IDLE, CHASE, WANDER}
const HITFORCE = 333
const REPEL = 333
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var state = IDLE
	#visible
export var Acceleration = 150
export var Friction = 100
export var MaxSpeed = 66

#objects to load
var DeathEffect = preload("res://MannyTest/Effects/DeathEffect.tscn")
onready var stats = $Stats
onready var detection = $DetectZone
onready var sprite = $BatSprite
onready var hurtBox = $HurtBox
onready var softbox = $SoftCollision

#signals
signal dead
######------FUNCTIONS-----######
###===SYSTEM===###
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 3 * HITFORCE * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
			lookfor_player()
		WANDER:
			pass
		CHASE:
			var player = detection.player
			if player != null:
				var direction = ((player.global_position - Vector2(0,-8)) - global_position ).normalized()
				
				velocity = velocity.move_toward(direction * MaxSpeed, Acceleration * delta)
			else: state = IDLE
		
	sprite.flip_h = velocity.x < 0
	if softbox.colliding():
		velocity += softbox.push() * delta * REPEL
	velocity = move_and_slide(velocity)
###===SIGNALS===###
func _on_HurtBox_area_entered(area):
	stats.HP -= area.damage
	knockback = area.knockback_vec * HITFORCE
	hurtBox.hit_effect()
	
func _on_Stats_dead():
	die()
	queue_free()
###===USER===###
func lookfor_player():
	if detection.sees_player():
		state = CHASE
func die():
	PlayerStats.maxHP += 1
	var deathEffect = DeathEffect.instance()
	deathEffect.global_position = global_position
	print("deathEffect instance created")
	get_parent().add_child(deathEffect)
	emit_signal("dead")
