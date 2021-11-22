extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 250
const MAXSPEED = 80
const JUMPFORCE = 300
const ACCEL = 10

var HP = 200
var EnemyHP = 200
var motion = Vector2()
var facingRight = true 
var isGrounded
var enemyIsDead = false
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facingRight == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facingRight = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facingRight = false
		$AnimationPlayer.play_backwards("Run")
	elif Input.is_action_pressed("defend"):
		$AnimationPlayer.play("Def")
	elif Input.is_action_pressed("attack2"):
		$AnimationPlayer.play("Attack2")
	elif Input.is_action_pressed("attack"):
		$AnimationPlayer.play("Attack1")
	else:  
		motion.x = 0                           
		$AnimationPlayer.play("Idle")
		
	if is_on_floor():      	
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
	if !is_on_floor():		
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("Fall")
	motion = move_and_slide(motion, UP)
	while Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("attack2"):
		if $RayCast2D.is_colliding():
			EnemyHP -= 20
			print(EnemyHP)
			if EnemyHP <= 0:
				enemyIsDead = true
func Spab():
	$AnimationPlayer.play("SpAb")
