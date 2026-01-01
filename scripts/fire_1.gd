extends Area2D

var g = global.levels_data[0]
@export var speed = g["speed"]
#@export var despawn:= 150

var direction := Vector2.ZERO

func _ready():
	add_to_group("fire")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):	
		queue_free()
		body.die()
		
	
func _process(delta):
	position += direction * speed * delta
	
	#var rect = get_viewport().get_visible_rect().grow(despawn)
	
	#if not rect.has_point(global_position):
		#queue_free()
		 
