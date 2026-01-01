extends CanvasLayer


@onready var timer: Timer = $Timer
@onready var game = $"../Game"
@onready var countdown = %time
@onready var title = %title
@onready var lvl = $".."

var rem
var min
var sec

func timer_start(time):
	timer.start(time)

func _ready() -> void:
	pass
	#global.add_coins(10)
	#print("Coins: "+str(global.coins)+"$")

func _process(delta: float) -> void:
	rem = int(timer.time_left)
	min = str(rem / 60)
	sec = str(rem % 60)
	
	if(rem < 119):
		title.hide()
	
	if(int(sec)>9):
		countdown.text = "0" + min + ":" + sec
	else:
		countdown.text = "0" + min + ":0" + sec
		
	
	#print(rem)
	#print(min)
	#print(sec)
	

	#if (timer.time_left > 120):
		#countdown.text = "02:00"
	#elif(timer.time_left > 70):
		#countdown.text = "01:" + str(int(timer.time_left)-60)
	#elif (timer.time_left > 60):
		#countdown.text = "01:0" + str(int(timer.time_left)-60)
	#elif (timer.time_left > 10):
		#countdown.text = "00:" + str(int(timer.time_left))
	#else:
		#countdown.text = "00:0" + str(int(timer.time_left))
	#


func _on_timer_timeout() -> void:
	print("Done")
	game.gameoff()
	global.level_end(rem)
	
	
