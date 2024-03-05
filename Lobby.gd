extends Node2D

@onready var lobby_title_label = %LobbyTitleLabel
@onready var player_info_label = %PlayerInfoLabel
@onready var player_list = %PlayerList
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func refresh_player_list():
	for child in player_list.get_children():
		player_list.remove_child(child)
	for player in Global.players:
		var player_label = Label.new()
		player_label.text = "Player %d (%s)" % [player.id, player.username]
		player_list.add_child(player_label)


func _on_timer_timeout():
	refresh_player_list()

func _on_back_button_pressed():
	#SceneManager.perform_scene_change("res://Index.tscn")
	pass


func _on_play_button_pressed():
	#SceneManager.perform_scene_change("res://Main.tscn")
	pass
