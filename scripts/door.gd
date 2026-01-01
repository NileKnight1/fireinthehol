extends Area2D

var doorb1 = false

func _on_body_entered(body: Node2D) -> void:
	doorb1 = true

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	doorb1 = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and doorb1 == true:
		global.level_play(1)
	
		
