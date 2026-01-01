extends Node2D


var g = global.levels_data[global.current_level-1]
@export var sc: PackedScene
@export var ar := Rect2(Vector2.ZERO, Vector2(1280,720))
@export var player: Node2D
@export var s_time = g["s_time"]
@export var s_pad = g["s_pad"]
@export var min_dis = g["min_dis"]
@export var total_time = g["time"]

@export var gameon = false
var next = false

@onready var level_label = %level
@onready var main_timer = $"../CanvasLayer"
@onready var border = $"../Map/border"
@onready var border2 = $"../Map/border2/col"
@onready var start_area = $"../Map/start/col"


var timer := 0.0

func _ready() -> void:
	level_label.text = "Level " + str(global.current_level)
	print (s_time)

func gameoff():
	gameon = false
	border.collision_layer = 0

func _on_start_body_entered(body: Node2D) -> void:
	gameon = true
	main_timer.timer_start(total_time)
	print("Game on")
	border2.set_deferred("disabled", false)
	start_area.set_deferred("disabled", true)

func _on_next_body_entered(body: Node2D) -> void:
	next = true
func _on_next_body_exited(body: Node2D) -> void:
	next = false


func _process(delta):
	if Input.is_action_just_pressed("interact") and next == true:
		#print(1)
		if(global.current_level == 10):
			global.levels(global.current_level+1)
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		else:
			global.levels(global.current_level+1)
			global.level_play(global.current_level+1)
		#return
		

	timer += delta
	if timer >= s_time and gameon == true:
		timer = 0
		spawn()

func spawn1():
	#var fire = sc.ins_timeantiate()
	var side = randi() % 4
	var size = ar.size
	var pos : Vector2
	var dir : Vector2
	#print("Spawn side:", side)

	var viewport_size := get_viewport_rect().size
	
	var camera := get_viewport().get_camera_2d()

	var cam_pos := camera.global_position
	var half := viewport_size * 0.5

	match side:
		0:
			pos = Vector2(randf_range(cam_pos.x - half.x, cam_pos.x + half.x), cam_pos.y - half.y - s_pad)
		1: 
			pos = Vector2(randf_range(cam_pos.x - half.x, cam_pos.x + half.x), cam_pos.y + half.y + s_pad)
		2:
			pos = Vector2(cam_pos.x - half.x - s_pad, randf_range(cam_pos.y - half.y, cam_pos.y + half.y))
		3:
			pos = Vector2(cam_pos.x + half.x + s_pad,randf_range(cam_pos.y - half.y, cam_pos.y + half.y))

	dir = (player.global_position - pos).normalized()
	
	return { "pos": pos, "dir": dir }


func spawn():
	#print("game1/func spawn")
	if player == null:
		return
		
	var fire = sc.instantiate()
	var data = spawn1()
	
	if data.pos.distance_to(player.global_position) < min_dis:
		fire.queue_free()
		return
	
	fire.global_position = data.pos
	fire.direction = data.dir
	
	add_child(fire)
