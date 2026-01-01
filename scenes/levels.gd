extends Control


func _ready() -> void:
	#global.levels(3)
	#print(global.coins)
	#print(global.last_level)
	
	for i in range(global.last_level-1):
		#print(i)
		var level = get_node("level%d" % (i + 1))
		level.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")



func _on_level_2_pressed() -> void:
	global.level_play(2)
func _on_level_3_pressed() -> void:
	global.level_play(3)
func _on_level_4_pressed() -> void:
	global.level_play(4)
func _on_level_5_pressed() -> void:
	global.level_play(5)
func _on_level_6_pressed() -> void:
	global.level_play(6)
func _on_level_7_pressed() -> void:
	global.level_play(7)
func _on_level_8_pressed() -> void:
	global.level_play(8)
func _on_level_9_pressed() -> void:
	global.level_play(9)
func _on_level_10_pressed() -> void:
	global.level_play(10)
