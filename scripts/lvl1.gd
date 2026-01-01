extends Node2D

@onready var coins = %coins

func _ready() -> void:
	update_coins()

func update_coins():
	coins.text = "💰 : " + str(global.coins)+"$"
