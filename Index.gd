extends Node2D

@onready var game_win_mode_label = %GameWinModeLabel
@onready var one_button = $ColorRect/VBoxContainer/HBoxContainer/OneButton
@onready var two_button = $ColorRect/VBoxContainer/HBoxContainer/TwoButton
@onready var three_button = $ColorRect/VBoxContainer/HBoxContainer/ThreeButton
@onready var panel_container = %PanelContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	game_win_mode_label.hide()
	GDSync.lobby_joined.connect(lobby_joined)
	GDSync.lobby_join_failed.connect(lobby_join_failed)
	GDSync.lobby_created.connect(lobby_created)
	GDSync.lobby_creation_failed.connect(lobby_creation_failed)
	

func _on_button_pressed():
	panel_container.show()


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



func _on_creat_lobby_button_pressed():
	GDSync.create_lobby(
		"zhufree's Lobby",
		"123",
		true,
		2,
		{
			'game_win_mode': Global.game_win_mode,
			'host': GDSync.get_client_id()
		}, {
			'host': GDSync.get_client_id()
		}
	)


func _on_join_lobby_button_pressed():
	GDSync.join_lobby("zhufree's Lobby", "123")


func lobby_created(lobby_name : String):
	print("Succesfully created lobby "+lobby_name)
	Global.lobby_name = lobby_name
	# 创建之后还要加入
	GDSync.join_lobby("zhufree's Lobby", "123")
	SceneManager.perform_scene_change("res://Lobby.tscn")

func lobby_creation_failed(lobby_name : String, error : int):
	match(error):
		ENUMS.LOBBY_CREATION_ERROR.LOBBY_ALREADY_EXISTS:
			push_error("A lobby with the name "+lobby_name+" already exists.")
		ENUMS.LOBBY_CREATION_ERROR.NAME_TOO_SHORT:
			push_error(lobby_name+" is too short.")
		ENUMS.LOBBY_CREATION_ERROR.NAME_TOO_LONG:
			push_error(lobby_name+" is too long.")
		ENUMS.LOBBY_CREATION_ERROR.PASSWORD_TOO_LONG:
			push_error("The password for "+lobby_name+" is too long.")
		ENUMS.LOBBY_CREATION_ERROR.TAGS_TOO_LARGE:
			push_error("The tags have exceeded the 2048 byte limit.")
		ENUMS.LOBBY_CREATION_ERROR.DATA_TOO_LARGE:
			push_error("The data have exceeded the 2048 byte limit.")
		ENUMS.LOBBY_CREATION_ERROR.ON_COOLDOWN:
			push_error("Please wait a few seconds before creating another lobby.")

func lobby_joined(lobby_name : String):
	print("Succesfully joined lobby "+lobby_name)
	Global.lobby_name = lobby_name
	SceneManager.perform_scene_change("res://Lobby.tscn")

func lobby_join_failed(lobby_name : String, error : int):
	match(error):
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_DOES_NOT_EXIST:
			push_error("The lobby "+lobby_name+" does not exist.")
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_IS_CLOSED:
			push_error("The lobby "+lobby_name+" is closed.")
		ENUMS.LOBBY_JOIN_ERROR.LOBBY_IS_FULL:
			push_error("The lobby "+lobby_name+" is full.")
		ENUMS.LOBBY_JOIN_ERROR.INCORRECT_PASSWORD:
			push_error("The password for lobby "+lobby_name+" was incorrect.")
		ENUMS.LOBBY_JOIN_ERROR.DUPLICATE_USERNAME:
			push_error("The lobby "+lobby_name+" already contains your username.")
	  
