extends CharacterBody2D

var SPEED = 100.0
var JUMP_VELOCITY = -250.0

@onready var lvl = $".."
@onready var player = $AnimatedSprite2D

@export var health = 3
@onready var hps = %hp
@onready var timer = $"../CanvasLayer/Timer"

func die():
	#print(health)
	
	health -= 1
	if(health == 2): hps.text = "HP: ❤️❤️"
	if(health == 1): hps.text = "HP: ❤️"

	if(health < 1):
		global.level_end(int(timer.time_left))
		
		#get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("move_left", "move_right")
	var running = 0
	
	if Input.is_action_pressed("sprint"):
		SPEED = 150.0
		JUMP_VELOCITY = -300.0
		running = 1
	else:
		SPEED = 100.0
		JUMP_VELOCITY = -250.0
		
	
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	if direction > 0:
		player.flip_h = false
	elif direction < 0:
		player.flip_h = true
		
		
	if is_on_floor():
		if direction == 0:
			player.play("idle")
		else:
			if running == 0:
				player.play("walk")
			else:
				player.play("run")
	else:
		player.play("jump")
	
	move_and_slide()
