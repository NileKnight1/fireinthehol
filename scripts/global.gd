extends Node

var coins = 0
var last_level = 1
var current_level = 1
const path := "user://save.dat"

func _ready() -> void:
	load_data()
	
func add_coins(c):
	coins += c
	save_data()
	
func levels(c):
	if(c > 10):
		c = 10
	if not (c < last_level):
		last_level = c
	save_data()

func save_data():
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(coins)
	file.store_var(last_level)
	file.close()
	
func load_data():
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		coins = file.get_var()
		last_level = file.get_var()
		file.close()
	else:
		save_data()

var levels_data = [
	{"s_time": 2, "s_pad": 32, "min_dis": 200, "speed": 50, "time": 60},
	{"s_time": 2, "s_pad": 32, "min_dis": 200, "speed": 100, "time":90},
	{"s_time": 1, "s_pad": 32, "min_dis": 200, "speed": 50, "time": 90},
	{"s_time": 1, "s_pad": 32, "min_dis": 200, "speed": 50, "time": 120},
	{"s_time": 1, "s_pad": 32, "min_dis": 100, "speed": 150, "time":60},
	{"s_time": 1, "s_pad": 32, "min_dis": 100, "speed": 150, "time":90},
	{"s_time": 1, "s_pad": 32, "min_dis": 100, "speed": 150, "time":120},
	{"s_time": 0.5, "s_pad": 32, "min_dis": 100, "speed": 100, "time":90},
	{"s_time": 0.5, "s_pad": 32, "min_dis": 100, "speed": 150, "time":90},
	{"s_time": 0.5, "s_pad": 32, "min_dis": 100, "speed": 150, "time":120},
	
		
	
]

func level_play(level):
	if(level > 10):
		current_level = 1
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	current_level = level
	get_tree().change_scene_to_file("res://scenes/level1.tscn")

func level_end(time):
	print("------")
	print(time)
	print("------")
	
	get_tree().call_group("fire", "queue_free")
	
	if(time == 0):
		print("Level completed")
		add_coins(
			current_level*50
		)
	else:
		add_coins(int(
			10*current_level* (
				(levels_data[current_level-1]["time"]-time)/30
				)
			))
		get_tree().reload_current_scene()
