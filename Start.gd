extends Node2D

@onready var game_win_mode_label = %GameWinModeLabel
@onready var one_button = $ColorRect/VBoxContainer/HBoxContainer/OneButton
@onready var two_button = $ColorRect/VBoxContainer/HBoxContainer/TwoButton
@onready var three_button = $ColorRect/VBoxContainer/HBoxContainer/ThreeButton
@onready var panel_container = %PanelContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	game_win_mode_label.hide()

func _on_button_pressed():
	panel_container.show()

func _on_one_button_pressed():
	game_win_mode_label.show()
	game_win_mode_label.text = one_button.text

func _on_two_button_pressed():
	game_win_mode_label.show()
	game_win_mode_label.text = two_button.text

func _on_three_button_pressed():
	game_win_mode_label.show()
	game_win_mode_label.text = three_button.text
