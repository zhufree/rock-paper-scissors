extends Node2D

@onready var game_win_mode_label = %GameWinModeLabel
@onready var one_button = $ColorRect/VBoxContainer/HBoxContainer/OneButton
@onready var two_button = $ColorRect/VBoxContainer/HBoxContainer/TwoButton
@onready var three_button = $ColorRect/VBoxContainer/HBoxContainer/ThreeButton

# Called when the node enters the scene tree for the first time.
func _ready():
	game_win_mode_label.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_one_button_pressed():
	Global.game_win_mode = 1
	game_win_mode_label.show()
	game_win_mode_label.text = one_button.text


func _on_two_button_pressed():
	Global.game_win_mode = 2
	game_win_mode_label.show()
	game_win_mode_label.text = two_button.text


func _on_three_button_pressed():
	Global.game_win_mode = 3
	game_win_mode_label.show()
	game_win_mode_label.text = three_button.text
